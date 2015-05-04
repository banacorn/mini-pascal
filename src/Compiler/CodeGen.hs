module Compiler.CodeGen where

-- import Control.Monad.Except
import Compiler.Type.Pipeline
import Compiler.AST.Type

import LLVM.General.AST

toModule :: ABT -> Pipeline Module
toModule _ = return defaultModule {
        moduleName = "program"
    ,   moduleDefinitions = []
    }
