module Compiler.CodeGen where

-- import Control.Monad.Except
import Compiler.Type.Pipeline
import Compiler.AST.Type

import LLVM.General.AST

genCode :: ABT -> Pipeline Module
genCode _ = return defaultModule {
        moduleName = "program"
    ,   moduleDefinitions = []
    }
