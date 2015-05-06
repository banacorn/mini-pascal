{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler.CodeGen where

import Control.Applicative
import Control.Monad.State hiding (void)
import qualified Data.Map as Map
import Data.Word

import Compiler.Type.Pipeline
import qualified Compiler.AST.Type as AST

import LLVM.General.AST.Type
import LLVM.General.AST
import LLVM.General.AST.Global as Glb
import LLVM.General.AST.Constant as C
import LLVM.General.AST.Float as F
import LLVM.General.AST.CallingConvention as CC
import LLVM.General.AST.Linkage as L
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
        index :: Int                            -- Block index
    ,   stack :: [Named Instruction]            -- Stack of instructions
    ,   term  :: Maybe (Named Terminator)       -- Block terminator
    }   deriving Show

newtype Codegen a = Codegen { unCodegen :: State CodegenState a }
    deriving (Functor, Applicative, Monad, MonadState CodegenState )

emptyCodegen :: CodegenState
emptyCodegen = CodegenState (Name "entry") Map.empty 1 Map.empty 0 Map.empty

execCodegen :: Codegen a -> (a, CodegenState)
execCodegen c = runState (unCodegen c) emptyCodegen

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


ret :: Operand -> Named Terminator
ret val = Do $ Ret (Just val) []

call :: Operand -> [Operand] -> Codegen Operand
call fn args = instr $ Call False CC.C [] (Right fn) (map toArg args) [] []
    where   toArg a = (a, [])

alloca :: Type -> Codegen Operand
alloca ty = instr $ Alloca ty Nothing 0 []

store :: Operand -> Operand -> Codegen Operand
store ptr val = instr $ Store False ptr val Nothing 0 []

load :: Operand -> Codegen Operand
load ptr = instr $ Load False ptr Nothing 0 []

-- genFactor :: AST.Factor AST.Value -> Codegen Operand
-- genFactor (AST.VariableFactor val) = do
--      load
-- genFactor (AST.NumberFactor lit) = genLiteral lit
-- genFactor (AST.InvocationFactor func params) = _
-- genFactor (AST.SubFactor expr) = _
-- genFactor (AST.NotFactor factor) = _

-- genVariable :: AST.Value -> Codegen Operand
-- genVariable (AST.Variable sym _) = return $
-- genVariable _ = error "not variable"

genLiteral :: AST.Value -> Codegen Operand
genLiteral (AST.IntLiteral n _) = return $ ConstantOperand (C.Int 32 (toInteger n))
genLiteral (AST.RealLiteral n _) = return $ ConstantOperand (C.Float (F.Double n))
genLiteral _ = error "not literal"
--
--
-- data Value  = Variable Symbol Declaration
--             | IntLiteral Int Position
--             | RealLiteral Double Position
--             deriving (Eq, Ord)

--
-- genExpression :: AST.Expression Value -> Codegen Operand
-- genExpression (UnaryExpression a) =
-- genExpression (BinaryExpression a op b) =
--
--
-- genSimpleExpression :: AST.SimpleExpression Value -> Codegen Operand
-- genSimpleExpression (TermSimpleExpression a) =
-- genSimpleExpression (OpSimpleExpression a op b) =

-- Definitions
genType :: AST.Type -> Type
genType (AST.BasicType AST.IntType) = i32
genType (AST.BasicType AST.RealType) = double
genType (AST.BasicType AST.VoidType) = void
genType (AST.FunctionType _) = error "can't gen higher order type"

genGlobalVariable :: AST.Declaration -> Definition
genGlobalVariable (AST.Declaration (AST.Symbol name _) typ) = GlobalDefinition $ globalVariableDefaults {
        Glb.name = Name name
    ,   Glb.type' = genType typ
    ,   Glb.linkage = L.Common
    ,   Glb.initializer = Just (C.Int 32 0)
    }

genFunction :: AST.Declaration -> [BasicBlock] -> Definition
genFunction (AST.Declaration (AST.Symbol label _) typ) body = GlobalDefinition $ functionDefaults {
        name        = Name label
    ,   parameters  = ([ Parameter (genType p) (Name "p") [] | p <- AST.getParamType typ ], False)
    ,   returnType  = genType (AST.getReturnType typ)
    ,   basicBlocks = body
    }

genModule :: AST.ABT -> Module
genModule (AST.Program decs _) = defaultModule {
        moduleName = "program"
    ,   moduleDefinitions =
                [ genGlobalVariable dec | dec <- decs, AST.isVariable (AST.decType dec) ]
            -- ++  [ genFunction dec []    | dec <- decs, AST.isFunction (AST.decType dec) ]
            ++  [putchar]
            ++  [main]
    }
    where
            main = GlobalDefinition $ functionDefaults {
                            name = Name "main"
                        ,   returnType = VoidType
                        ,   basicBlocks = [
                                BasicBlock (Name "block entry") [
                                    -- Name "new" := Alloca i32 Nothing 0 [] --(Just (ConstantOperand (GlobalReference i32 (Name "b"))))
                                    Do $ Store False (ConstantOperand (GlobalReference i32 (Name "b"))) (ConstantOperand (C.Int 32 97)) Nothing 0 []
                                    -- Do $
                                ,   Name "temp" := Load False (ConstantOperand (GlobalReference i32 (Name "b"))) Nothing 0 []
                                ,   Do (Call False CC.C [] (Right (ConstantOperand (GlobalReference (FunctionType i32 [i32] False) (Name "putchar")))) [(LocalReference i32 (Name "temp"), [])] [] [])
                                ] (Do $ Ret Nothing [])
                            ]
                        }
            putchar = GlobalDefinition $ functionDefaults {
                            name = Name "putchar"
                        ,   parameters = ([Parameter i32 (Name "c") []], False)
                        ,   returnType = i32
                        }

--
-- ++  [
--
--     ,   GlobalDefinition $ functionDefaults {
--                 name = Name "main"
--             ,   returnType = VoidType
--             ,   basicBlocks = [
--                     BasicBlock (Name "block entry") [] (Do $ Ret Nothing [])
--                 ]
--             }
--     ,   GlobalDefinition $ functionDefaults {
--                 name = Name "putchar"
--             ,   parameters = ([Parameter i32 (Name "c") []], False)
--             ,   returnType = i32
--             }
--
--     ]
