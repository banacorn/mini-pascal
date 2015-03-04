module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Class.Serializable
import Compiler.Type
import Compiler.Pipeline

import Control.Monad.IO.Class

main :: IO ()
main = pipeline $ do
    testA
    -- testWithSource "program aaa(); begin end." >>= scan >>= parse >>= liftIO . print

testA :: Pipeline ()
testA = do

    readSource "./test/semantics/test.p"
        >>= scan
        >>= parse
        >>= checkBinding
        >>= checkType
        >>= draw


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
