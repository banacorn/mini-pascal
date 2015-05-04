module Compiler.CodeGen where

-- import Control.Monad.Except
import Compiler.Type.Pipeline
import qualified Compiler.AST.Type as AST
import Compiler.AST.Type hiding (Type)

import LLVM.General.AST
import LLVM.General.AST.Type
import LLVM.General.AST.Global as Glb

genType :: AST.Type -> Type
genType (BasicType IntType) = i32
genType (BasicType RealType) = double
genType (BasicType AST.VoidType) = void
genType (AST.FunctionType _) = error "can't gen higher order type"

genGlobalVariable :: Declaration -> Definition
genGlobalVariable (Declaration (Symbol name _) typ) = GlobalDefinition $ globalVariableDefaults {
        Glb.name = Name name
    ,   Glb.type' = genType typ
    }

toModule :: ABT -> Module
toModule (Program decs _ _) = defaultModule {
        moduleName = "program"
    ,   moduleDefinitions = [ genGlobalVariable dec | dec <- decs, not (isFunction (decType dec)) ] 
    }
