module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Serialize
import Data.List (intercalate)

main :: IO ()
main = testOne

testOne :: IO ()
testOne = readFile "./test/parser/no-parsing-error/parser-test.p" >>= putStr . serialize . parse . scan

testAll :: IO ()
testAll = mapM_ run filenames
    where
        run s = readFile (pathPrefix ++ s) >>= print . parse . scan
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
