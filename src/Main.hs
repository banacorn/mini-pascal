module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Data.List (intercalate)

main :: IO ()
main = do
    file "parser/no-parsing-error/test-constant"
    -- file "parser/no-parsing-error/test-operator"
    -- file "parser/no-parsing-error/test04"
    -- file "scanner/scanner-test01"
    -- getContents >>= print . scan

file :: String -> IO ()
file name = do
    -- s <- readFile "./test/scanner/scanner-test01.p"
    s <- readFile $ "./test/" ++ name ++ ".p"
    putStrLn s
    putStrLn "\n==========\n"
    putStrLn (intercalate "\n" $ map show $ scan s)
