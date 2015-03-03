{-# LANGUAGE FlexibleInstances #-}

module Compiler.DSL.ABT where

import Compiler.Type
import Compiler.Type.DSL

import Data.Monoid

-- import qualified    Data.Set as Set
-- import              Data.Bifunctor

--------------------------------------------------------------------------------
-- TypeCheck data type
data TypeCheck = Screwed [TypeError]
               | GotType Value Type
               deriving (Eq)


data TypeError  = TypeMismatch Value Type Type -- expected, got
                | ExpectArray Value  -- got to be array
                | NotInvocable -- got to be subprogram
                | IndexNotInt Value -- got to be all Int
                | ArityError Value -- wrong number of parameters
                deriving (Eq)

instance Monoid TypeCheck where
    mempty = Screwed []
    Screwed e   `mappend` Screwed f   = Screwed (e ++ f)
    Screwed e   `mappend` GotType _ _ = Screwed e
    GotType _ _ `mappend` Screwed e   = Screwed e
    GotType x s `mappend` GotType y t | x == y = GotType y t
                                      | x /= y = Screwed [TypeMismatch y s t]


--------------------------------------------------------------------------------
-- Typeable!


-- (<=>) :: Typeable a => a -> TypeCheck -> TypeCheck
-- a <=> Screwed e = Screwed e
-- a <=> GotType b = case typeCheck a of
--     Just a' -> case a' == b' of
--         True -> Just a'
--         False -> Nothing
--     Nothing -> Nothing

(<=>) :: (Typeable a, Typeable b) => a -> b -> TypeCheck
a <=> b = typeCheck a <> typeCheck b


-- (<=~) :: (TypeCheck a, TypeCheck b) => a -> b -> Maybe Type
-- (<=~) a b = a <=> typeCheck b

typeCheckArray :: Value -> [Expression Value] -> TypeCheck
typeCheckArray var indices
    | not notSubprogram && not indicesChecked = Screwed [IndexNotInt var, ExpectArray var] 
    |     notSubprogram && not indicesChecked = Screwed [IndexNotInt var]
    | not notSubprogram &&     indicesChecked = Screwed [ExpectArray var]
    |     notSubprogram &&     indicesChecked = let Type [domain] = arrayType in check domain indices
    where   indicesChecked = all (gotTypeInt . typeCheck) indices
            notSubprogram = firstOrder arrayType

            gotTypeInt (GotType _ (Type [IntType])) = True
            gotTypeInt _                            = False

            Variable _ dec = var
            arrayType = decType dec

            check _                         []     = GotType var arrayType
            check (ArrayType (m, n) domain) (i:is) = check domain is
            check _                         (i:is) = Screwed [ExpectArray var]

-- typeCheckInvoke :: Variable -> [Expression Variable] -> TypeCheck
-- typeCheckInvoke var params

class Typeable a where
    typeCheck :: a -> TypeCheck

instance Typeable (Expression Value) where
    typeCheck (UnaryExpression e) = typeCheck e
    typeCheck (BinaryExpression a _ b) = a <=> b

instance Typeable (SimpleExpression Value) where
    typeCheck (TermSimpleExpression e) = typeCheck e
    typeCheck (OpSimpleExpression a _ b) = a <=> b

instance Typeable (Term Value) where
    typeCheck (FactorTerm e) = typeCheck e
    typeCheck (OpTerm a _ b) = a <=> b
    typeCheck (NegTerm e) = typeCheck e

instance Typeable (Factor Value) where
    typeCheck (ArrayAccessFactor a es) = typeCheckArray a es
    typeCheck (InvocationFactor a es) = typeCheck a
    typeCheck (NumberFactor e) = typeCheck e
    typeCheck (SubFactor e) = typeCheck e
    typeCheck (NotFactor e) = typeCheck e

instance Typeable Value where
    typeCheck v@(Variable _ (Declaration _ t)) = GotType v t
    typeCheck v@(IntLiteral _)                 = GotType v (Type [IntType])
    typeCheck v@(RealLiteral _)                = GotType v (Type [RealType])



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
