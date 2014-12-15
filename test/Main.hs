module Main where

import Test.Framework (defaultMain)

import qualified Test.Scanner

main :: IO ()
main = defaultMain
    [   Test.Scanner.tests
    ]
