module Compiler where

import Compiler.Syntax.Lexer
import Compiler.Syntax.Parser
import Compiler.Pipeline
import Compiler.CodeGen
import Compiler.JIT

main :: IO ()
main = pipeline $ do
    readSource "./test/code/semantics/test.p"
        >>= scan
        >>= parse
        >>= checkBinding
        >>= checkType
        >>= printIt'
        >>= toModule
        -- >>= toIRAssembly
        >>= runJIT
        >>= printIt'

    printIt "=== Success ==="
