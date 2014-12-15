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
    [   identifierTests
    ,   commentTest
    ,   stringTests
    ,   numberTests
    ,   arbitraryTests
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

commentTest :: Framework.Test
commentTest = "Comment" @= scan "//this is a very long comment and includes letter and symbol qwertyui~@%hopasdfghjkl;.,mnbvcxz`1234567890p;mdsf4577846799tj,vsffdfger~!@#$%^&*()POIUYEP{{}_+|_{\"?><MZXCVB\n" =?= Right []

arbitraryTests :: Framework.Test
arbitraryTests = testGroup "Arbitrary"
    [   "array declaration" @= test0
    ]
    where
        test0 = scan "var kki, iii: array [ 23 .. 57 ] of array [ 23 .. 57 ] of integer;" =?= Right [(TokVar,Position 0 1 1),(TokID "kki",Position 4 1 5),(TokComma,Position 7 1 8),(TokID "iii",Position 9 1 10),(TokColon,Position 12 1 13),(TokArr,Position 14 1 15),(TokLSB,Position 20 1 21),(TokNum "23",Position 22 1 23),(TokTo,Position 25 1 26),(TokNum "57",Position 28 1 29),(TokRSB,Position 31 1 32),(TokOf,Position 33 1 34),(TokArr,Position 36 1 37),(TokLSB,Position 42 1 43),(TokNum "23",Position 44 1 45),(TokTo,Position 47 1 48),(TokNum "57",Position 50 1 51),(TokRSB,Position 53 1 54),(TokOf,Position 55 1 56),(TokTypeInt,Position 58 1 59),(TokSemicolon,Position 65 1 66)]

stringTests :: Framework.Test
stringTests = testGroup "String"
    [   "single quote" @= test0
    ,   "double quote" @= test1
    ,   "empty single quote" @= test2
    ,   "empty double quote" @= test3
    ,   "multiline single quote" @= test4
    ,   "multiline double quote" @= test5
    ]
    where
        test0 = scan "'single quote'" =?= Right [(TokNum "'single quote'", Position 0 1 1)]
        test1 = scan "\"double quote\"" =?= Right [(TokNum "\"double quote\"", Position 0 1 1)]
        test2 = scan "''" =?= Right [(TokNum "''", Position 0 1 1)]
        test3 = scan "\"\"" =?= Right [(TokNum "\"\"", Position 0 1 1)]
        test4 = scan "'a\nb\nc'" =?= Right [(TokNum "'a\nb\nc'", Position 0 1 1)]
        test5 = scan "\"a\nb\nc\"" =?= Right [(TokNum "\"a\nb\nc\"", Position 0 1 1)]

numberTests :: Framework.Test
numberTests = testGroup "Number"
    [   "integer" @= test0
    ,   "negative integer" @= test1
    ,   "real" @= test2
    ,   "negative real" @= test3
    ,   "scientific notation" @= test4
    ]
    where
        test0 = scan "0" =?= Right [(TokNum "0", Position 0 1 1)]
        test1 = scan "-0" =?= Right [(TokMinus, Position 0 1 1), (TokNum "0", Position 1 1 2)]
        test2 = scan "3.14" =?= Right [(TokNum "3.14", Position 0 1 1)]
        test3 = scan "-3.14" =?= Right [(TokMinus, Position 0 1 1), (TokNum "3.14", Position 1 1 2)]
        test4 = scan "10.3E+5" =?= Right [(TokNum "10.3E+5", Position 0 1 1)]
