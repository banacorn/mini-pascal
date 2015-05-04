module Compiler where

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

    toIRAssembly (toModule abt) >>= printIt'
        -- >>= printIt
        -- >>= runJIT
        -- >>= printIt'

    printIt "=== Success ==="
