module Compiler.JIT where


import Control.Applicative

import Control.Monad.Except
import Compiler.Type.Pipeline
import Compiler.PreAST.Type

import LLVM.General
import qualified LLVM.General.AST as IR
import LLVM.General.Context
import LLVM.General.ExecutionEngine as EE
import Foreign.Ptr

foreign import ccall "dynamic" mkFun :: FunPtr (IO ()) -> (IO ())

runForeignFunction :: FunPtr a -> IO ()
runForeignFunction fn = mkFun (castFunPtr fn :: FunPtr (IO ()))

jit :: Context -> (EE.MCJIT -> IO a) -> IO a
jit context = EE.withMCJIT context optLvl model ptrElim fPreASTIns
    where
        optLvl      = Just 2  -- optimization level
        model       = Nothing -- code model ( Default )
        ptrElim     = Nothing -- frame pointer elimination
        fPreASTIns  = Nothing -- fPreAST instruction

withModuleFromIR :: (Module -> IO a) -> IR.Module -> Pipeline a
withModuleFromIR f mod = do
    result <- liftIO $ withContext $ \context -> do
        runExceptT $ withModuleFromAST context mod f
    case result of
        Left err -> throwError $ CompileErrorClass err
        Right as -> return as


runJIT :: IR.Module -> Pipeline ()
runJIT = withModuleFromIR $ \mod ->
            withContext $ \context ->
                jit context $ \engine ->
                    EE.withModuleInEngine engine mod $ \ee -> do
                        mainFunction <- EE.getFunction ee (IR.Name "main")
                        case mainFunction of
                            Just fn -> runForeignFunction fn
                            Nothing -> void $ putStrLn "function not found"




toAssembly :: IR.Module -> Pipeline String
toAssembly = withModuleFromIR moduleLLVMAssembly
