module Test.Helper where

import qualified    Test.Framework                          as Framework
-- import              Test.Framework
import              Test.HUnit
import              Test.Framework.Providers.HUnit

import              Control.Monad.Except
import              Control.Monad.State
import              Compiler.Type.Pipeline

infixr 5 =?=
(=?=) :: (Show a, Eq a) => Pipeline a -> (Either ErrorClass a) -> Assertion
f =?= a = do
    result <- evalStateT (runExceptT f) (Zustand Nothing Nothing [])
    result @?= a

infixr 4 @=, =@
(@=) :: Framework.TestName -> Assertion -> Framework.Test
s @= m = testCase s m

(=@) :: Assertion -> Framework.TestName -> Framework.Test
s =@ m = testCase m s
