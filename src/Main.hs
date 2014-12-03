module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Serialize
import Compiler.Scope
import Data.List (intercalate)

main :: IO ()
main = do
    source <- testOne
    let parseTree = parse (scan source)
    draw . head $ getScope parseTree
    draw parseTree

draw :: Serializable a => a -> IO ()
draw = putStrLn . serialize

pipeline :: String -> IO ()
pipeline = print . getScope . parse . scan

testOne :: IO String
testOne = readFile "./test/parser/no-parsing-error/parser-test.p"

testAll :: IO ()
testAll = mapM_ run filenames
    where
        run s = readFile (pathPrefix ++ s) >>= pipeline
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
