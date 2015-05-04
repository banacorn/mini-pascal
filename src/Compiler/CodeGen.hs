module Compiler.CodeGen where

import Control.Monad.Except
import Compiler.Type.Pipeline
import Compiler.AST.Type

import LLVM.General
import qualified LLVM.General.AST as AST
import LLVM.General.Context

genCode :: ABT -> Pipeline AST.Module
genCode _ = return AST.defaultModule


runJIT :: AST.Module -> Pipeline String
runJIT mod = do
    result <- liftIO $ withContext $ \context -> do
        runExceptT $ withModuleFromAST context mod moduleLLVMAssembly
    case result of
        Left err -> throwError $ CompileErrorClass err
        Right as -> return as
