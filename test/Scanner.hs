module Test.Scanner where

import qualified    Test.Framework                          as Framework
import              Test.Framework
import              Test.HUnit
import              Test.Framework.Providers.HUnit

import Control.Monad.Except

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
    ]
    where
        test0 = scan "abc" =?= Right [(TokID "abc", Position 0 1 1)]
        test1 = scan "abc0" =?= Right [(TokID "abc0", Position 0 1 1)]
        test2 = scan "0abc" =?= Left (LexError (Position 0 1 1) "TokError \"0abc\"")


infixr 5 =?=
(=?=) :: (Show a, Eq a) => Pipeline a -> Either PipelineError a -> Assertion
f =?= a = do
    result <- runExceptT f
    result @?= a

infixr 4 @=
(@=) :: Framework.TestName -> Assertion -> Framework.Test
s @= m = testCase s m
