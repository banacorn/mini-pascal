module Compiler where

import Control.Monad.State

import Compiler.Syntax.Lexer
import Compiler.Syntax.Parser
import Compiler.Pipeline
import Compiler.Codegen
import Compiler.JIT

import  Compiler.AST.Instances

main :: IO ()
main = pipeline $ do
    ast <- readSource "./test/code/test.p"
        >>= scan
        >>= parse

        >>= printIt'
        >>= checkBinding
        -- >>= checkType
        >>= convert
        >>= printIt'


    printIt "\n=== ASSEMBLY ===\n"
    as <- toIRAssembly (genModule ast) >>= printIt'
    liftIO $ writeFile "./test/llvm/test.ll" as

    printIt "\n=== JIT ==="
    runJIT (genModule ast) >>= printIt'
