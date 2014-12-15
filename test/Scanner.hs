module Test.Scanner where

import qualified    Test.Framework                          as Framework
import              Test.Framework
import              Test.HUnit
import              Test.Framework.Providers.HUnit
import              Test.Helper

import Compiler.Lexer
import Compiler.Types

tests :: Framework.Test
tests = testGroup "Scanner"
    [    identifierTests

    ]

identifierTests :: Framework.Test
identifierTests = testGroup "Identifier"
    [   "alphabet"              @= test0
    ,   "alphabet + digits"     @= test1
    ,   "digits + alphabet"     @= test2
    ,   "alphabet + underscore" @= test3
    ]
    where
        test0 = scan "abc" =?= Right [(TokID "abc", Position 0 1 1)]
        test1 = scan "abc0" =?= Right [(TokID "abc0", Position 0 1 1)]
        test2 = scan "0abc" =?= Left (LexError (Position 0 1 1) "TokError \"0abc\"")
        test3 = scan "ab_c" =?= Left (LexError (Position 2 1 3) "TokError \"_\"")
