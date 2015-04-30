module Test.Syntax.Lexer where

import qualified    Test.Framework                          as Framework
import              Test.Framework
import              Test.HUnit
import              Test.Framework.Providers.HUnit
import              Test.Helper

import Compiler.Syntax.Lexer
import Compiler.Syntax.Type.Position
import Compiler.Syntax.Type.Token
import Compiler.Type.Pipeline


tests :: Framework.Test
tests = testGroup "Scanner"
    [   identifierTests
    ,   commentTest
    ,   numberTests
    -- ,   arbitraryTests
    -- ,   stringTests
    ]

identifierTests :: Framework.Test
identifierTests = testGroup "Identifier"
    [   "alphabet"              @= test0
    ,   "alphabet + digits"     @= test1
    ,   "digits + alphabet"     @= test2
    ,   "alphabet + underscore" @= test3
    ]
    where
        test0 = scan "abc"  =?= Right [Token (TokID "abc") (Position 0 3 1 1)]
        test1 = scan "abc0" =?= Right [Token (TokID "abc0") (Position 0 4 1 1)]
        test2 = scan "0abc" =?= Right [Token (TokError "0abc") (Position 0 4 1 1)]
        test3 = scan "ab_c" =?= Right [ Token (TokID "ab") (Position 0 2 1 1)
                                      , Token (TokError "_") (Position 2 1 1 3)
                                      , Token (TokID "c") (Position 3 1 1 4)
                                      ]

commentTest :: Framework.Test
commentTest = "Comment" @= scan "//this is a very long comment and includes letter and symbol qwertyui~@%hopasdfghjkl;.,mnbvcxz`1234567890p;mdsf4577846799tj,vsffdfger~!@#$%^&*()POIUYEP{{}_+|_{\"?><MZXCVB\n" =?= Right []


numberTests :: Framework.Test
numberTests = testGroup "Number"
    [   test0 =@ "integer"
    ,   test1 =@ "negative integer"
    ,   test2 =@ "real"
    ,   test3 =@ "negative real"
    ]
    where
        test0 = scan "0"        =?= Right [Token (TokInt "0") (Position 0 1 1 1)]
        test1 = scan "-0"       =?= Right [Token TokMinus (Position 0 1 1 1), Token (TokInt "0") (Position 1 1 1 2)]
        test2 = scan "3.14"     =?= Right [Token (TokReal "3.14") (Position 0 4 1 1)]
        test3 = scan "-3.14"    =?= Right [Token TokMinus (Position 0 1 1 1), Token (TokReal "3.14") (Position 1 4 1 2)]

--
-- arbitraryTests :: Framework.Test
-- arbitraryTests = testGroup "Arbitrary"
--     [   "array declaration" @= test0
--     ]
--     where
--         test0 = scan "var kki, iii: array [ 23 .. 57 ] of array [ 23 .. 57 ] of integer;" =?= Right
--             [   Token TokVar            (Position 0 3 1 1)
--             ,   Token (TokID "kki")     (Position 4 3 1 5)
--             ,   Token TokComma          (Position 7 1 1 8)
--             ,   Token (TokID "iii")     (Position 9 3 1 10)
--             ,   Token TokColon          (Position 12 1 1 13)
--             ,   Token TokArr            (Position 14 5 1 15)
--             ,   Token TokLSB            (Position 20 1 1 21)
--             ,   Token (TokNum "23")     (Position 22 2 1 23)
--             ,   Token TokTo             (Position 25 2 1 26)
--             ,   Token (TokNum "57")     (Position 28 2 1 29)
--             ,   Token TokRSB            (Position 31 1 1 32)
--             ]
--             --(TokTo,Position 25 1 26),(TokNum "57",Position 28 1 29),(TokRSB,Position 31 1 32),(TokOf,Position 33 1 34),(TokArr,Position 36 1 37),(TokLSB,Position 42 1 43),(TokNum "23",Position 44 1 45),(TokTo,Position 47 1 48),(TokNum "57",Position 50 1 51),(TokRSB,Position 53 1 54),(TokOf,Position 55 1 56),(TokTypeInt,Position 58 1 59),(TokSemicolon,Position 65 1 66)]
-- stringTests :: Framework.Test
-- stringTests = testGroup "String"
--     [   "single quote"              @= test0
--     ,   "double quote"              @= test1
--     ,   "empty single quote"        @= test2
--     ,   "empty double quote"        @= test3
--     ,   "multiline single quote"    @= test4
--     ,   "multiline double quote"    @= test5
--     ]
--     where
--         test0 = scan "'single quote'"   =?= Right [(TokNum "'single quote'", Position 0 1 1)]
--         test1 = scan "\"double quote\"" =?= Right [(TokNum "\"double quote\"", Position 0 1 1)]
--         test2 = scan "''"               =?= Right [(TokNum "''", Position 0 1 1)]
--         test3 = scan "\"\""             =?= Right [(TokNum "\"\"", Position 0 1 1)]
--         test4 = scan "'a\nb\nc'"        =?= Right [(TokNum "'a\nb\nc'", Position 0 1 1)]
        -- test5 = scan "\"a\nb\nc\""      =?= Right [(TokNum "\"a\nb\nc\"", Position 0 1 1)]
