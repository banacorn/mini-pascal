{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler.Codegen where

import Control.Applicative
import Control.Monad
import Control.Monad.State hiding (void)
import qualified Data.Map as Map
import Data.Word
import Data.List (sortBy)
import Data.Function (on)

import Compiler.Type.Pipeline
import qualified Compiler.AST.Type as AST

import LLVM.General.AST.Type hiding (void)
import LLVM.General.AST
import LLVM.General.AST.Global as Glb
import qualified LLVM.General.AST.Constant as C
import qualified LLVM.General.AST.Float as F
import qualified LLVM.General.AST.CallingConvention as CC
import qualified LLVM.General.AST.Linkage as L
import qualified LLVM.General.AST.IntegerPredicate as IP

type SymbolTable = [(String, Operand)]

data CodegenState = CodegenState {
        currentBlock        :: Name                     -- Name of the active block to append to
    ,   blocks              :: Map.Map Name BlockState  -- Blocks for function
    ,   blockCount          :: Int                      -- Count of basic blocks
    ,   names               :: Map.Map String Int       -- Name Supply
    ,   count               :: Word                     -- Count of unnamed instructions
    ,   symtab              :: Map.Map String Operand   -- Function scope symbol table
    }   deriving Show

data BlockState = BlockState {
        idx   :: Int                            -- Block index
    ,   stack :: [Named Instruction]            -- Stack of instructions
    ,   term  :: Maybe (Named Terminator)       -- Block terminator
    }   deriving Show

newtype Codegen a = Codegen { unCodegen :: State CodegenState a }
    deriving (Functor, Applicative, Monad, MonadState CodegenState )

emptyCodegen :: CodegenState
emptyCodegen = CodegenState (Name "entry") Map.empty 1 Map.empty 0 Map.empty

execCodegen :: Codegen a -> CodegenState
execCodegen c = execState (unCodegen c) emptyCodegen

-- blockCount
incrBlockCount :: Codegen ()
incrBlockCount = modify $ \s -> s { blockCount = blockCount s + 1 }

-- count
freshNo :: Codegen Word
freshNo = do
    i <- gets count
    modify $ \s -> s { count = i + 1 }
    return (i + 1)

-- name
freshName :: String -> Codegen Name
freshName name = do
    names' <- gets names
    case Map.lookup name names' of
        Nothing -> do
            insertName name 1
            return (Name name)
        Just ix -> do
            insertName name (ix + 1)
            return (Name $ name ++ show ix)
    where
            insertName :: String -> Int -> Codegen ()
            insertName name no = modify $ \s -> s { names = Map.insert name no (names s)  }

--------------------------------------------------------------------------------
--  Blocks
--------------------------------------------------------------------------------

emptyBlock :: Int -> BlockState
emptyBlock i = BlockState i [] Nothing

setBlock :: Name -> Codegen Name
setBlock name = do
    modify $ \s -> s { currentBlock = name }
    return name

getBlock :: Codegen Name
getBlock = gets currentBlock

addBlock :: String -> Codegen Name
addBlock name = do
    index <- gets blockCount
    name' <- freshName name
    insertBlock name' (emptyBlock index)
    incrBlockCount
    return  name'

    where   insertBlock :: Name -> BlockState -> Codegen ()
            insertBlock name state = modify $ \s -> s { blocks = Map.insert name state (blocks s)  }

getCurrentBlock :: Codegen BlockState
getCurrentBlock = do
    current <- gets currentBlock
    blks <- gets blocks
    case Map.lookup current blks of
        Just x -> return x
        Nothing -> error $ "No such block: " ++ show current

modifyBlock :: BlockState -> Codegen ()
modifyBlock new = do
    current <- gets currentBlock
    modify $ \s -> s { blocks = Map.insert current new (blocks s) }

createBlocks :: CodegenState -> [BasicBlock]
createBlocks m = map makeBlock $ sortBy (compare `on` (idx . snd)) $ Map.toList (blocks m)

makeBlock :: (Name, BlockState) -> BasicBlock
makeBlock (label, (BlockState _ s t)) = BasicBlock label s (maketerm t)
    where   maketerm (Just x) = x
            maketerm Nothing = Do $ Ret Nothing [] -- error $ "Block has no terminator:" ++ (show label)

--------------------------------------------------------------------------------
--  Symbol Table
--------------------------------------------------------------------------------

setVar :: String -> Operand -> Codegen ()
setVar var x = do
    table <- gets symtab
    modify $ \s -> s { symtab = Map.insert var x table }

getVar :: String -> Codegen Operand
getVar var = do
    table <- gets symtab
    case Map.lookup var table of
        Just x  -> return x
        Nothing -> error $ "Local variable not in scope: " ++ show var

--------------------------------------------------------------------------------
--  Instructions
--------------------------------------------------------------------------------

instr :: Instruction -> Codegen Operand
instr ins = do
    n <- freshNo
    block <- getCurrentBlock
    let i = stack block
    let ref = (UnName n)
    modifyBlock $ block { stack = i ++ [ref := ins] }
    return (LocalReference i32 ref)

terminator :: Named Terminator -> Codegen (Named Terminator)
terminator trm = do
    current <- getCurrentBlock
    modifyBlock (current { term = Just trm })
    return trm

terminateAnyway :: Bool -> Codegen ()
terminateAnyway isVoid = do
    current <- getCurrentBlock
    case term current of
        Just x -> return ()
        Nothing -> do
            if isVoid then retVoid else ret (literal 0)
            return ()

--------------------------------------------------------------------------------
--  Reference
--------------------------------------------------------------------------------

local ::  Name -> Operand
local = LocalReference i32

global ::  Name -> Operand
global = ConstantOperand . C.GlobalReference i32

--------------------------------------------------------------------------------
--  Arithmetic and Constants
--------------------------------------------------------------------------------

literal :: Int -> Operand
literal n = ConstantOperand $ C.Int 32 (toInteger n)

add :: Operand -> Operand -> Codegen Operand
add a b = instr $ Add True True a b []

sub :: Operand -> Operand -> Codegen Operand
sub a b = instr $ Sub True True a b []

mul :: Operand -> Operand -> Codegen Operand
mul a b = instr $ Mul True True a b []

sdiv :: Operand -> Operand -> Codegen Operand
sdiv a b = instr $ SDiv True a b []

cmp :: Operand -> Operand -> IP.IntegerPredicate -> Codegen Operand
cmp a b ip = do
    result <- instr $ ICmp ip a b []
    instr $ ZExt result i32 []

phi :: [(Operand, Name)] -> Codegen Operand
phi nodes = instr $ Phi i32 nodes []


--------------------------------------------------------------------------------
--  Effects
--------------------------------------------------------------------------------

call :: Operand -> [Operand] -> Codegen Operand
call fn args = instr $ Call False CC.C [] (Right fn) (map toArg args) [] []
    where   toArg a = (a, [])

alloca :: Codegen Operand
alloca = instr $ Alloca i32 Nothing 0 []

store :: Operand -> Operand -> Codegen Operand
store ptr val = instr $ Store False ptr val Nothing 0 []

load :: Operand -> Codegen Operand
load ptr = instr $ Load False ptr Nothing 0 []

--------------------------------------------------------------------------------
--  Control Flow
--------------------------------------------------------------------------------

br :: Name -> Codegen (Named Terminator)
br val = terminator $ Do $ Br val []

cbr :: Operand -> Name -> Name -> Codegen (Named Terminator)
cbr cond tr fl = do
    cond' <- instr $ Trunc cond i1 []
    terminator $ Do $ CondBr cond' tr fl []

retVoid :: Codegen (Named Terminator)
retVoid = terminator $ Do $ Ret Nothing []

ret :: Operand -> Codegen (Named Terminator)
ret val = terminator $ Do $ Ret (Just val) []

ret' :: Operand -> Codegen Operand
ret' val = ret val >> return val

--------------------------------------------------------------------------------
--  Convert Program AST to Codegen
--------------------------------------------------------------------------------

genParameter :: AST.Variable -> Codegen Operand
genParameter v@(AST.Variable label _) = do
    new <- alloca
    setVar label new
    store new (local (Name label))
    -- setVar label (local (Name label))

genLocalVariable :: AST.Variable -> Codegen ()
genLocalVariable (AST.Variable label _) = do
    new <- alloca
    setVar label new

genFunctionRef :: AST.Variable -> Codegen Operand
genFunctionRef (AST.Variable label AST.Global) = return $ global (Name label)
genFunctionRef (AST.Variable label _) = error "not a referencing a function"

genExpression :: AST.Expression -> Codegen Operand
genExpression (AST.UnaryExpression expr) = genSimpleExpression expr
genExpression (AST.BinaryExpression expr0 relOp expr1) = do
    a <- genSimpleExpression expr0
    b <- genSimpleExpression expr1
    cmp a b (toIP relOp)
    where   toIP AST.S = IP.SLT
            toIP AST.L = IP.SGT
            toIP AST.E = IP.EQ
            toIP AST.NE = IP.NE
            toIP AST.SE = IP.SLE
            toIP AST.LE = IP.SGE

genSimpleExpression :: AST.SimpleExpression -> Codegen Operand
genSimpleExpression (AST.TermSimpleExpression term) = genTerm term
genSimpleExpression (AST.OpSimpleExpression simpleExpr AST.Plus term) = do
    a <- genSimpleExpression simpleExpr
    b <- genTerm term
    add a b
genSimpleExpression (AST.OpSimpleExpression simpleExpr AST.Minus term) = do
    a <- genSimpleExpression simpleExpr
    b <- genTerm term
    sub a b

genTerm :: AST.Term -> Codegen Operand
genTerm (AST.FactorTerm factor) = genFactor factor
genTerm (AST.OpTerm term AST.Mul factor) = do
    a <- genTerm term
    b <- genFactor factor
    mul a b
genTerm (AST.OpTerm term AST.Div factor) = do
    a <- genTerm term
    b <- genFactor factor
    sdiv a b
genTerm (AST.NegTerm factor) = do
    val <- genFactor factor
    sub (literal 0) val
genFactor :: AST.Factor -> Codegen Operand
genFactor (AST.VariableFactor (AST.Variable label AST.Global)) = do
    load $ global (Name label)
genFactor (AST.VariableFactor (AST.Variable label AST.Local)) = do
    var <- getVar label
    load var
genFactor (AST.VariableFactor (AST.Variable label AST.Declaration)) = error "shouldn't be referencing stuffs"
genFactor (AST.LiteralFactor lit) = return $ literal lit
genFactor (AST.InvocationFactor var exprs) = do
    fn <- genFunctionRef var
    args <- mapM genExpression exprs
    call fn args
genFactor (AST.SubFactor expr) = genExpression expr
-- genFactor (NotFactor factor) = do
--     val <- genFactor factor

genStatement :: AST.Statement -> Codegen Operand
genStatement (AST.Assignment (AST.Variable label AST.Global) expr) = do
    let var = global (Name label)
    val <- genExpression expr
    store var val
genStatement (AST.Assignment (AST.Variable label AST.Local) expr) = do
    var <- getVar label
    val <- genExpression expr
    store var val
genStatement (AST.Assignment (AST.Variable label AST.Declaration) expr) = error "shouldn't be referencing stuffs"
genStatement (AST.Return expr) = genExpression expr >>= ret'
genStatement (AST.Invocation var exprs) = do
    fn <- genFunctionRef var
    args <- mapM genExpression exprs
    call fn args
genStatement (AST.Compound stmts) = sequence (map genStatement stmts) >>= returnLastResult
    where   returnLastResult results = return $ if null results
                                        then MetadataStringOperand "dummy operand"
                                        else last results
genStatement (AST.Branch cond tr fl) = do
    ifThen <- addBlock "if.then"
    ifElse <- addBlock "if.else"
    ifExit <- addBlock "if.exit"

    -- entry
    ------------------
    condResult <- genExpression cond
    test <- cmp condResult (literal 1) IP.EQ
    cbr test ifThen ifElse

    -- if.then
    ------------------
    setBlock ifThen
    trVal <- genStatement tr        -- Generate code for the true branch
    br ifExit                       -- Branch to the merge block
    ifThen <- getBlock

    -- if.else
    ------------------
    setBlock ifElse
    flVal <- genStatement fl        -- Generate code for the false branch
    br ifExit                       -- Branch to the merge block
    ifElse <- getBlock

    -- if.exit
    ------------------
    setBlock ifExit
    phi [(trVal, ifThen), (flVal, ifElse)]


genStatement (AST.Loop cond body) = do
    whileBody <- addBlock "while.body"
    whileTest <- addBlock "while.test"
    whileExit <- addBlock "while.exit"

    -- entry
    ------------------
    br whileTest                     -- Branch to the loop body block

    -- test
    ------------------
    setBlock whileTest
    condResult <- genExpression cond
    test <- cmp condResult (literal 1) IP.EQ
    cbr test whileBody whileExit       -- Generate the loop condition

    -- body
    ------------------
    setBlock whileBody
    genStatement body              -- Generate the loop body
    br whileTest

    -- exit
    ------------------
    setBlock whileExit
    return $ MetadataStringOperand "dummy operand"
genGlobalVariable :: AST.Variable -> Definition
genGlobalVariable (AST.Variable label _) = GlobalDefinition $ globalVariableDefaults {
        Glb.name = Name label
    ,   Glb.type' = i32
    ,   Glb.linkage = L.Common
    ,   Glb.initializer = Just (C.Int 32 0)
    }


returnLastResult :: [Operand] -> Codegen ()
returnLastResult results = if null results
    then return ()
    else void $ ret $ last results

genFunction :: AST.Function -> Definition
genFunction (AST.Function label ret params decs body) = GlobalDefinition $ functionDefaults {
        name        = Name label
    ,   parameters  = ([ Parameter i32 (Name name) [] | AST.Variable name _ <- params ], False)
    ,   returnType  = if ret then VoidType else i32
    ,   basicBlocks = createBlocks . execCodegen $ do
            entry <- addBlock "entry"
            setBlock entry
            sequence (map genParameter params)
            sequence (map genLocalVariable decs)
            sequence (map genStatement body)
            terminateAnyway ret
    }

genModule :: AST.Program -> Module
genModule (AST.Program vars funcs) = defaultModule {
        moduleName = "program"
    ,   moduleDefinitions = (map genGlobalVariable vars)
                         ++ (map genFunction funcs)
                         ++ [getchar, putchar]
    }
    where
            -- main = GlobalDefinition $ functionDefaults {
            --                 name = Name "main"
            --             ,   returnType = VoidType
            --             ,   basicBlocks = [
            --                     BasicBlock (Name "block entry") [
            --                         -- Name "new" := Alloca i32 Nothing 0 [] --(Just (ConstantOperand (GlobalReference i32 (Name "b"))))
            --                         Do $ Store False (ConstantOperand (GlobalReference i32 (Name "b"))) (ConstantOperand (C.Int 32 97)) Nothing 0 []
            --                         -- Do $
            --                     ,   Name "temp" := Load False (ConstantOperand (GlobalReference i32 (Name "b"))) Nothing 0 []
            --                     ,   Do (Call False CC.C [] (Right (ConstantOperand (GlobalReference (FunctionType i32 [i32] False) (Name "putchar")))) [(LocalReference i32 (Name "temp"), [])] [] [])
            --                     ] (Do $ Ret Nothing [])
            --                 ]
            --             }
            getchar = GlobalDefinition $ functionDefaults {
                            name = Name "getchar"
                        ,   parameters = ([], False)
                        ,   returnType = i32
                        }

            putchar = GlobalDefinition $ functionDefaults {
                            name = Name "putchar"
                        ,   parameters = ([Parameter i32 (Name "c") []], False)
                        ,   returnType = i32
                        }
