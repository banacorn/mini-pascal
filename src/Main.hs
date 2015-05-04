module Compiler where

import Compiler.Syntax.Lexer
import Compiler.Syntax.Parser
import Compiler.Pipeline
import Compiler.CodeGen

main :: IO ()
main = pipeline $ do
    readSource "./test/code/semantics/test.p"
        >>= scan
        >>= parse
        >>= checkBinding
        >>= checkType
        >>= genCode
        >>= runJIT
        >>= printIt'

    printIt "=== Success ==="
