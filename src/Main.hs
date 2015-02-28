module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Class.Serializable
import Compiler.Scope.Declaration
import Compiler.Scope.Occurrence
import Compiler.Scope.Binding
import Compiler.Type
import Compiler.Pipeline
import Compiler.Semantics

import Control.Monad.IO.Class


main :: IO ()
main = pipeline $ do
    testA
    -- testWithSource "program aaa(); begin end." >>= scan >>= parse >>= liftIO . print

testA :: Pipeline ()
testA = do

    ast <- readSource "./test/semantics/test.p"
    -- ast <- readSource "./test/semantics/test-duplicate.p"
        >>= scan
        >>= parse

    let decScope = getDeclarationScope ast
    let occScope = getOccurrenceScope ast
    let bindingTree = buildBindingTree [] (Just decScope) occScope

    -- checkDeclarationDuplication decScope
    draw ast
    draw decScope
    draw occScope
    draw bindingTree
    -- >>= liftIO . draw

testAll :: Pipeline ()
testAll = mapM_ run filenames
    where
        run s = readSource (pathPrefix ++ s)
            >>= scan
            >>= parse
            -- >>= return . getDeclarationScope
            -- >>= draw
        pathPrefix = "./test/parser/no-parsing-error/"
        filenames =
            [   "parser-test.p"
            ,   "test-constant.p"
            ,   "test-recursion.p"
            ,   "test02-uninitialized-var.p"
            ,   "test-operator.p"
            ,   "test-operator2.p"
            ,   "test00-runtime-range-check.p"
            ,   "test04.p"
            ,   "test-function.p"
            ,   "test-procedure.p"
            ,   "test01-global-var.p"
            ]
