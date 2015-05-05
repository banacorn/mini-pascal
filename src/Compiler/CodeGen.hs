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
import LLVM.General.AST.CallingConvention as CC


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


insertBlock :: Name -> BlockState -> Codegen ()
insertBlock name state = modify $ \s -> s { blocks = Map.insert name state (blocks s)  }

incrBlockCount :: Codegen ()
incrBlockCount = modify $ \s -> s { blockCount = blockCount s + 1 }

insertName :: String -> Int -> Codegen ()
insertName name no = modify $ \s -> s { names = Map.insert name no (names s)  }

freshNo :: Codegen Word
freshNo = do
    i <- gets count
    modify $ \s -> s { count = i + 1 }
    return (i + 1)

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

emptyBlock :: Int -> BlockState
emptyBlock i = BlockState i [] Nothing

emptyCodegen :: CodegenState
emptyCodegen = CodegenState (Name "entry") Map.empty 1 Map.empty 0 Map.empty

runCodegen :: Codegen a -> (a, CodegenState)
runCodegen c = runState (unCodegen c) emptyCodegen

f = do
    freshBlock "hello"

freshBlock :: String -> Codegen Name
freshBlock name = do
    index <- gets blockCount
    name' <- freshName name
    insertBlock name' (emptyBlock index)
    incrBlockCount
    return  name'

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

instr :: Type -> Instruction -> Codegen Operand
instr typ ins = do
    n <- freshNo
    block <- currentBlock
    let i = stack block
    let ref = (UnName n)
    modifyBlock $ block { stack = i ++ [ref := ins] }
    return (LocalReference typ ref)



-- entry :: Codegen Name
-- entry = gets currentBlock
--
-- addBlock :: String -> Codegen Name
-- addBlock bname = do
--     bls <- gets blocks
--     ix  <- gets blockCount
--     nms <- gets names
--
--     let new = emptyBlock ix
--         (qname, supply) = uniqueName bname nms
--
--     modify $ \s -> s { blocks = Map.insert (Name qname) new bls
--                      , blockCount = ix + 1
--                      , names = supply
--                      }
--     return (Name qname)
--
-- setBlock :: Name -> Codegen Name
-- setBlock bname = do
--     modify $ \s -> s { currentBlock = bname }
--     return bname
--
-- getBlock :: Codegen Name
-- getBlock = gets currentBlock
--
-- modifyBlock :: BlockState -> Codegen ()
-- modifyBlock new = do
--     active <- gets currentBlock
--     modify $ \s -> s { blocks = Map.insert active new (blocks s) }
--
-- current :: Codegen BlockState
-- current = do
--     c <- gets currentBlock
--     blks <- gets blocks
--     case Map.lookup c blks of
--         Just x -> return x
--         Nothing -> error $ "No such block: " ++ show c
--
--
ret :: Operand -> Named Terminator
ret val = Do $ Ret (Just val) []

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
                                    Do (Call False CC.C [] (Right (ConstantOperand (GlobalReference (FunctionType i32 [i32] False) (Name "putchar")))) [(ConstantOperand (Int 32 99), [])] [] [])
                                ,   Do (Call False CC.C [] (Right (ConstantOperand (GlobalReference (FunctionType i32 [i32] False) (Name "putchar")))) [(ConstantOperand (Int 32 101), [])] [] [])
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
