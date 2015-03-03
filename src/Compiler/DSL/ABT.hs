module Compiler.DSL.ABT where

import Compiler.Type
import Compiler.Type.DSL

-- import qualified    Data.Set as Set
-- import              Data.Bifunctor

--------------------------------------------------------------------------------


-- class TypeCheck a where
--     typeCheck :: a -> Maybe Type
--
-- instance TypeCheck Factor where
--     typeCheck (ArrayAccessFactor sym exprs) =

-- --------------------------------------------------------------------------------
-- -- Expression (with >/>=/=....)
-- data Expression a = UnaryExpression (SimpleExpression a)
--                   | BinaryExpression (SimpleExpression a) RelOp (SimpleExpression a)
--                   deriving Functor
--
-- --------------------------------------------------------------------------------
-- -- Simple Expression (with +/-)
-- data SimpleExpression a = TermSimpleExpression (Term a)
--                         | OpSimpleExpression (SimpleExpression a) AddOp (Term a)
--                         deriving Functor
--
-- --------------------------------------------------------------------------------
-- -- Term (with *//)
-- data Term a = FactorTerm (Factor a)
--             | OpTerm (Term a) MulOp (Factor a)
--             | NegTerm (Factor a)
--             deriving Functor


-- data Factor a = ArrayAccessFactor a [Expression a]     -- id[]
--               | InvocationFactor  a [Expression a]     -- id()
--               | NumberFactor      Literal
--               | SubFactor         (Expression a)       -- (...)
--               | NotFactor         (Factor a)           -- -id
--               deriving Functor
