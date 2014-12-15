module Test.Helper where

import qualified    Test.Framework                          as Framework
-- import              Test.Framework
import              Test.HUnit
import              Test.Framework.Providers.HUnit

import Control.Monad.Except
import Compiler.Types

infixr 5 =?=
(=?=) :: (Show a, Eq a) => Pipeline a -> Either PipelineError a -> Assertion
f =?= a = do
    result <- runExceptT f
    result @?= a

infixr 4 @=
(@=) :: Framework.TestName -> Assertion -> Framework.Test
s @= m = testCase s m
