module Compiler where

import Control.Monad.State

import Compiler.Syntax.Lexer
import Compiler.Syntax.Parser
import Compiler.Pipeline
import Compiler.CodeGen
import Compiler.JIT

main :: IO ()
main = pipeline $ do
    abt <- readSource "./test/code/test.p"
        >>= scan
        >>= parse
        >>= checkBinding
        >>= checkType
        >>= printIt'

    printIt "\n=== ASSEMBLY ===\n"
    as <- toIRAssembly (genModule abt) >>= printIt'
    liftIO $ writeFile "./test/llvm/test.ll" as
        -- >>= printIt
        -- >>= runJIT
        -- >>= printIt'

    printIt "\n=== JIT ==="
    runJIT (genModule abt) >>= printIt'
