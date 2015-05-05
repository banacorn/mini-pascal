{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler.CodeGen where

import Control.Monad.State hiding (void)
import qualified Data.Map as Map
import Compiler.Type.Pipeline
import qualified Compiler.AST.Type as AST

import LLVM.General.AST.Type
import LLVM.General.AST
import LLVM.General.AST.Global as Glb
import LLVM.General.AST.Constant as C



type SymbolTable = [(String, Operand)]

data CodegenState = CodegenState {
        currentBlock :: Name                     -- Name of the active block to append to
    ,   blocks       :: Map.Map Name BlockState  -- Blocks for function
    ,   symtab       :: SymbolTable              -- Function scope symbol table
    ,   blockCount   :: Int                      -- Count of basic blocks
    ,   count        :: Word                     -- Count of unnamed instructions
    -- ,   names        :: Names                    -- Name Supply
    }   deriving Show

data BlockState = BlockState {
        idx   :: Int                            -- Block index
    ,   stack :: [Named Instruction]            -- Stack of instructions
    ,   term  :: Maybe (Named Terminator)       -- Block terminator
    }   deriving Show

newtype Codegen a = Codegen { runCodegen :: State CodegenState a }
    deriving (Functor, Applicative, Monad, MonadState CodegenState )


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
    ,   parameters  = ([], False)
    ,   returnType  = genType (AST.getReturnType typ)
    ,   basicBlocks = body
    }

toModule :: AST.ABT -> Module
toModule (AST.Program decs _) = defaultModule {
        moduleName = "program"
    ,   moduleDefinitions =
                [ genGlobalVariable dec | dec <- decs, not (AST.isFunction (AST.decType dec)) ]
            ++  [   GlobalDefinition $ functionDefaults {
                            name = Name "main"
                        ,   returnType = VoidType
                        ,   basicBlocks = [
                                BasicBlock (Name "block entry") [] (Do $ Ret Nothing [])
                            ]
                        }
                ,   GlobalDefinition $ functionDefaults {
                            name = Name "putchar"
                        ,   parameters = ([Parameter i32 (Name "c") []], False)
                        ,   returnType = i32
                        }

                ]
    }
