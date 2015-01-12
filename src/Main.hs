module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Class.Serializable
import Compiler.Class.Scope
import Compiler.Type
import Compiler.Pipeline


import Control.Monad.IO.Class


main :: IO ()
main = handleError $ do
    testA
    -- testWithSource "program asdf" >>= scan >>= parse >>= liftIO . print

testA :: Pipeline ()
-- testOne = readSource "./test/semantics/test-duplicate.p"
testA = readSource "./test/semantics/test00-type-error-in-array.p"
    >>= scan
    >>= parse
    >>= return . head . getScope
    >>= draw
    -- >>= liftIO . draw

testAll :: Pipeline ()
testAll = mapM_ run filenames
    where
        run s = readSource (pathPrefix ++ s)
            >>= scan
            >>= parse
            >>= return . head . getScope
            >>= draw
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
