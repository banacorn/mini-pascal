module Compiler where

import Compiler.Lexer
import Data.List (intercalate)

main :: IO ()
main = do
    file
    -- getContents >>= print . scan

file :: IO ()
file = do
    s <- readFile "./test/scanner/scanner-test01.p"
    putStrLn s
    putStrLn "\n==========\n"
    putStrLn (intercalate "\n" $ map show $ scan s)
