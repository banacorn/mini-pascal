module Compiler.JIT where


import Control.Applicative

import Control.Monad.Except
import Compiler.Type.Pipeline
import Compiler.AST.Type

import LLVM.General
import qualified LLVM.General.AST as IR
import LLVM.General.Context
import LLVM.General.ExecutionEngine as EE
import Foreign.Ptr

foreign import ccall "dynamic" haskFun :: FunPtr (IO Double) -> (IO Double)

run :: FunPtr a -> IO String
run fn = show <$> haskFun (castFunPtr fn :: FunPtr (IO Double))

jit :: Context -> (EE.MCJIT -> IO a) -> IO a
jit context = EE.withMCJIT context optLvl model ptrElim fastIns
    where
        optLvl   = Just 2  -- optimization level
        model    = Nothing -- code model ( Default )
        ptrElim  = Nothing -- frame pointer elimination
        fastIns  = Nothing -- fast instruction

withModuleFromIR :: (Module -> IO a) -> IR.Module -> Pipeline a
withModuleFromIR f mod = do
    result <- liftIO $ withContext $ \context -> do
        runExceptT $ withModuleFromAST context mod f
    case result of
        Left err -> throwError $ CompileErrorClass err
        Right as -> return as


runJIT :: IR.Module -> Pipeline String
runJIT = withModuleFromIR $ \mod -> do
    withContext $ \context -> do
        jit context $ \engine ->
            EE.withModuleInEngine engine mod $ \ee -> do
                mainFunction <- EE.getFunction ee (IR.Name "main")
                case mainFunction of
                    Just fn -> run fn
                    Nothing -> return "Error!!"

toIRAssembly :: IR.Module -> Pipeline String
toIRAssembly = withModuleFromIR moduleLLVMAssembly