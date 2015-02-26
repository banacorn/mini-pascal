module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Class.Serializable
import Compiler.Interpret.DeclarationScope
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

    ast <- readSource "./test/semantics/test00-type-error-in-array.p"
    -- ast <- readSource "./test/semantics/test-duplicate.p"
        >>= scan
        >>= parse

    let decScope = getDeclarationScope ast

    checkDeclarationDuplication decScope
    draw ast
    draw decScope
    -- >>= liftIO . draw

testAll :: Pipeline ()
testAll = mapM_ run filenames
    where
        run s = readSource (pathPrefix ++ s)
            >>= scan
            >>= parse
            >>= return . getDeclarationScope
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
