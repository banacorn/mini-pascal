module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Class.Serializable
import Compiler.Type
import Compiler.Pipeline
-- import Compiler.Semantics
import Compiler.AST.Scope.Declaration
import Compiler.AST.Scope.Occurrence
import Compiler.AST.Scope.Binding
import Compiler.Type.ABT

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

    let decScope = collectDeclaration ast
    let occScope = collectOccurrence ast
    let bindScope = collectBinding ast

    -- checkDeclarationDuplicated decScope
    -- checkVariableUndeclared bindScope

    draw ast
    -- draw decScope
    -- draw occScope
    -- draw bindScope
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
