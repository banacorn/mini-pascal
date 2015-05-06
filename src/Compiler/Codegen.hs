{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler.Codegen where

import Control.Applicative
import Control.Monad.State hiding (void)
import qualified Data.Map as Map
import Data.Word
import Data.List (sortBy)
import Data.Function (on)

import Compiler.Type.Pipeline
import qualified Compiler.AST.Type as AST

import LLVM.General.AST.Type
import LLVM.General.AST
import LLVM.General.AST.Global as Glb
import qualified LLVM.General.AST.Constant as C
import qualified LLVM.General.AST.Float as F
import qualified LLVM.General.AST.CallingConvention as CC
import qualified LLVM.General.AST.Linkage as L
type SymbolTable = [(String, Operand)]

data CodegenState = CodegenState {
        currentBlockName    :: Name                     -- Name of the active block to append to
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
-- block
emptyBlock :: Int -> BlockState
emptyBlock i = BlockState i [] Nothing

freshBlock :: String -> Codegen Name
freshBlock name = do
    index <- gets blockCount
    name' <- freshName name
    insertBlock name' (emptyBlock index)
    incrBlockCount
    return  name'

    where   insertBlock :: Name -> BlockState -> Codegen ()
            insertBlock name state = modify $ \s -> s { blocks = Map.insert name state (blocks s)  }

currentBlock :: Codegen BlockState
currentBlock = do
    current <- gets currentBlockName
    blks <- gets blocks
    case Map.lookup current blks of
        Just x -> return x
        Nothing -> error $ "No such block: " ++ show current

modifyBlock :: BlockState -> Codegen ()
modifyBlock new = do
    current <- gets currentBlockName
    modify $ \s -> s { blocks = Map.insert current new (blocks s) }

-- symtab
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

--
instr :: Instruction -> Codegen Operand
instr ins = do
    n <- freshNo
    block <- currentBlock
    let i = stack block
    let ref = (UnName n)
    modifyBlock $ block { stack = i ++ [ref := ins] }
    return (LocalReference i32 ref)

terminator :: Named Terminator -> Codegen (Named Terminator)
terminator trm = do
    blk <- currentBlock
    modifyBlock (blk { term = Just trm })
    return trm



terminateAnyway :: Bool -> Codegen ()
terminateAnyway isVoid = do
    current <- currentBlock
    case term current of
        Just x -> return ()
        Nothing -> do
            if isVoid then retVoid else ret (literal 0)
            return ()


literal :: Int -> Operand
literal n = ConstantOperand $ C.Int 32 (toInteger n)
-- -- References
-- local ::  Name -> Operand
-- local = LocalReference double
--
-- global ::  Name -> C.Constant
-- global = C.GlobalReference double
--
-- externf :: Name -> Operand
-- externf = ConstantOperand . C.GlobalReference double

-- Arithmetic and Constants
add :: Operand -> Operand -> Codegen Operand
add a b = instr $ Add True True a b []

sub :: Operand -> Operand -> Codegen Operand
sub a b = instr $ Sub True True a b []

mul :: Operand -> Operand -> Codegen Operand
mul a b = instr $ Mul True True a b []


-- Effects
call :: Operand -> [Operand] -> Codegen Operand
call fn args = instr $ Call False CC.C [] (Right fn) (map toArg args) [] []
    where   toArg a = (a, [])

alloca :: Type -> Codegen Operand
alloca ty = instr $ Alloca ty Nothing 0 []

store :: Operand -> Operand -> Codegen Operand
store ptr val = instr $ Store False ptr val Nothing 0 []

load :: Operand -> Codegen Operand
load ptr = instr $ Load False ptr Nothing 0 []

-- Control Flow
br :: Name -> Codegen (Named Terminator)
br val = terminator $ Do $ Br val []

cbr :: Operand -> Name -> Name -> Codegen (Named Terminator)
cbr cond tr fl = terminator $ Do $ CondBr cond tr fl []

retVoid :: Codegen (Named Terminator)
retVoid = terminator $ Do $ Ret Nothing []

ret :: Operand -> Codegen (Named Terminator)
ret val = terminator $ Do $ Ret (Just val) []

createBlocks :: CodegenState -> [BasicBlock]
createBlocks m = map makeBlock $ sortBy (compare `on` (idx . snd)) $ Map.toList (blocks m)

makeBlock :: (Name, BlockState) -> BasicBlock
makeBlock (label, (BlockState _ s t)) = BasicBlock label s (maketerm t)
    where   maketerm (Just x) = x
            maketerm Nothing = error $ "Block has no terminator:" ++ (show label)

genExpression :: AST.Expression -> Codegen Operand
genExpression (AST.UnaryExpression expr) = genSimpleExpression expr
genExpression (AST.BinaryExpression expr0 relOp expr1) = undefined

genSimpleExpression :: AST.SimpleExpression -> Codegen Operand
genSimpleExpression (AST.TermSimpleExpression term) = genTerm term
genSimpleExpression (AST.OpSimpleExpression simpleExpr addOp term) = undefined

genTerm :: AST.Term -> Codegen Operand
genTerm (AST.FactorTerm factor) = genFactor factor
genTerm (AST.OpTerm term mulOp factor) = undefined -- OpTerm (convertTerm term) (convertMulOp mulOp) (convertFactor factor)
genTerm (AST.NegTerm factor) = undefined -- NegTerm (convertFactor factor)

genFactor :: AST.Factor -> Codegen Operand
genFactor (AST.LiteralFactor lit) = return $ literal lit
genFactor _ = undefined
-- genFactor (VariableFactor var) = -- VariableFactor (convertVariable var)
-- genFactor (InvocationFactor var exprs) = InvocationFactor (convertVariable var) (map convertExpression exprs)
-- genFactor (SubFactor expr) = SubFactor (convertExpression expr)
-- genFactor (NotFactor factor) = NotFactor (convertFactor factor)

genStatement :: AST.Statement -> Codegen ()
genStatement (AST.Return expr) = do
    genExpression expr >>= ret
    return ()


genGlobalVariable :: AST.Variable -> Definition
genGlobalVariable (AST.Variable label _) = GlobalDefinition $ globalVariableDefaults {
        Glb.name = Name label
    ,   Glb.type' = i32
    ,   Glb.linkage = L.Common
    ,   Glb.initializer = Just (C.Int 32 0)
    }

genFunction :: AST.Function -> Definition
genFunction (AST.Function label ret params decs body) = GlobalDefinition $ functionDefaults {
        name        = Name label
    ,   parameters  = ([ Parameter i32 (Name name) [] | AST.Variable name _ <- params ], False)
    ,   returnType  = if ret then void else i32
    ,   basicBlocks = createBlocks . execCodegen $ do
            freshBlock "entry"
            sequence_ (map genStatement body)
            -- if null body then return () else
            --     genStatement (head body)
            terminateAnyway ret
            -- ret $ genExpression (AST.UnaryExpression (AST.TermSimpleExpression (AST.FactorTerm (AST.LiteralFactor 3))))
    }

genModule :: AST.Program -> Module
genModule (AST.Program vars funcs) = defaultModule {
        moduleName = "program"
    ,   moduleDefinitions = (map genGlobalVariable vars)
                         ++ (map genFunction funcs)
                         ++ [putchar]
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
            putchar = GlobalDefinition $ functionDefaults {
                            name = Name "putchar"
                        ,   parameters = ([Parameter i32 (Name "c") []], False)
                        ,   returnType = i32
                        }
