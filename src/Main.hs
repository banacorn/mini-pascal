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

    printIt "\n=== ASSEMBLY ===\n"
    toIRAssembly (genModule abt) >>= printIt'
        -- >>= printIt
        -- >>= runJIT
        -- >>= printIt'

    printIt "\n=== JIT ===\n"
    runJIT (genModule abt) >>= printIt'
