module Compiler where

import Control.Monad.State

import Compiler.Syntax.Lexer
import Compiler.Syntax.Parser
import Compiler.Type.Pipeline
import Compiler.Serializable
import Compiler.Pipeline
import Compiler.Codegen
import Compiler.JIT

import Compiler.AST.Type
import Compiler.AST.Instances

main :: IO ()
main = pipeline $ do

    ast <- buildAST "./test/code/sampl.p"

    let m = genModule ast

    assembly <- toAssembly m

    printIt $ cyan "\n=== Mini Pascal AST ===\n"
    printIt ast


    printIt $ cyan "\n=== ASSEMBLY ===\n"
    printIt assembly
    liftIO (writeFile "./test/code/test.ll" assembly)

    printIt $ cyan "\n=== JIT ==="
    runJIT m >>= printIt




buildAST :: String -> Pipeline Program
buildAST src = readSource src
                >>= scan
                >>= parse
                >>= checkBinding
                >>= convert
