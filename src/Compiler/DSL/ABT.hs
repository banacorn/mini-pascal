{-# LANGUAGE FlexibleInstances #-}

module Compiler.DSL.ABT where

import Compiler.Type
import Compiler.Type.DSL

-- import qualified    Data.Set as Set
-- import              Data.Bifunctor

--------------------------------------------------------------------------------
--
-- sameType :: [Type] -> Maybe Type
-- sameType [] = Nothing
-- sameType [x] = Just x
-- sameType (x:xs) | x == sameType xs = x
--                 | otherwise        = Nothing

(<=>) :: TypeCheck a => a -> Maybe Type -> Maybe Type
a <=> Nothing = Nothing
a <=> Just b' = case typeCheck a of
    Just a' -> case a' == b' of
        True -> Just a'
        False -> Nothing
    Nothing -> Nothing

(<=~) :: (TypeCheck a, TypeCheck b) => a -> b -> Maybe Type
(<=~) a b = a <=> typeCheck b

-- compose :: TypeCheck a => [a] -> Maybe Type
-- compose [] = Nothing
-- compose [x] = typeCheck x
-- compose (x:xs) = do
--     Type x <- typeCheck x
--     Type xs' <- compose xs
--     return (Type (x ++ xs'))

typeCheckArray :: TypeCheck a => Variable -> [a] -> Maybe Type
typeCheckArray var indices
    | firstOrder arrayType = let Type [domain] = arrayType in check domain indices
    | otherwise = Nothing
    where   Variable _ dec = var
            arrayType = decType dec
            check (ArrayType (i, j) domain)



class TypeCheck a where
    typeCheck :: a -> Maybe Type

instance TypeCheck (Expression Variable) where
    typeCheck (UnaryExpression e) = typeCheck e
    typeCheck (BinaryExpression a _ b) = a <=~ b

instance TypeCheck (SimpleExpression Variable) where
    typeCheck (TermSimpleExpression e) = typeCheck e
    typeCheck (OpSimpleExpression a _ b) = a <=~ b

instance TypeCheck (Term Variable) where
    typeCheck (FactorTerm e) = typeCheck e
    typeCheck (OpTerm a _ b) = a <=~ b
    typeCheck (NegTerm e) = typeCheck e

instance TypeCheck (Factor Variable) where
    typeCheck (ArrayAccessFactor a es) = typeCheck a
    typeCheck (InvocationFactor a es) = typeCheck a
    typeCheck (NumberFactor e) = typeCheck e
    typeCheck (SubFactor e) = typeCheck e
    typeCheck (NotFactor e) = typeCheck e

instance TypeCheck Literal where
    typeCheck (IntLiteral _) = Just (Type [IntType])
    typeCheck (RealLiteral _) = Just (Type [RealType])

instance TypeCheck Variable where
    typeCheck (Variable _ (Declaration _ t)) = Just t



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
