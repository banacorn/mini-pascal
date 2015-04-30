module Main where

import Test.Framework (defaultMain)

import qualified Test.Syntax.Lexer

main :: IO ()
main = defaultMain
    [   Test.Syntax.Lexer.tests
    ]
