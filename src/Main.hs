module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Class.Serializable
import Compiler.Type
import Compiler.Pipeline

import Control.Monad.IO.Class

main :: IO ()
main = pipeline $ do
    readSource "./test/semantics/test.p"
        >>= scan
        >>= parse
        >>= checkBinding
        >>= checkType
        >>= draw
