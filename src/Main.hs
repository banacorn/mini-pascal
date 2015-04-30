module Compiler where

import Compiler.Syntax.Lexer
import Compiler.Syntax.Parser
import Compiler.Pipeline

main :: IO ()
main = pipeline $ do
    readSource "./test/code/semantics/test.p"
        >>= scan
        >>= printIt'
        -- >>= parse
        -- >>= checkBinding
        -- >>= checkType

    printIt "=== Success ==="
