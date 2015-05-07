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


    let m = genModule ast

    printIt "\n=== ASSEMBLY ===\n"
    as <- toAssembly m >>= printIt'
    liftIO $ writeFile "./test/llvm/test.ll" as

    printIt "\n=== JIT ==="
    runJIT m >>= printIt
