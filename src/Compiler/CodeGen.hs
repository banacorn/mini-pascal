module Compiler.CodeGen where

-- import Control.Monad.Except
import Compiler.Type.Pipeline
import Compiler.AST.Type

import LLVM.General.AST
import LLVM.General.AST.Type
import LLVM.General.AST.Global as Glb

toModule :: ABT -> Module
toModule _ = defaultModule {
        moduleName = "program"
    ,   moduleDefinitions = [
            GlobalDefinition $ globalVariableDefaults {
                    Glb.name = Name "banana"
                ,   Glb.type' = i32
                }
        ]
    }

--
--
-- genGlobalVariable :: ABT -> [GlobalDefinition]
-- genGlobalVariable (Program decs _)
