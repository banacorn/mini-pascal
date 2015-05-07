{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler.Codegen.State where

import Control.Applicative
import Control.Monad.State hiding (void)
import Data.Word
import Data.List (sortBy)
import Data.Function (on)
import qualified Data.Map as Map

import LLVM.General.AST.Type hiding (void)
import LLVM.General.AST


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




incrBlockCount :: Codegen ()
incrBlockCount = modify $ \s -> s { blockCount = blockCount s + 1 }

--------------------------------------------------------------------------------
--  Name Supply
--------------------------------------------------------------------------------

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
