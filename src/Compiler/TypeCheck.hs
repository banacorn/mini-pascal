{-# LANGUAGE FlexibleInstances #-}

module Compiler.TypeCheck (typeCheckStatement, TypeError(..)) where

import Compiler.Syntax.Type
import Compiler.Type.Type
import Compiler.DSL.Type
import Compiler.Serializable

import Data.Maybe

--------------------------------------------------------------------------------
-- TypeCheck data type
data TypeCheck = Screwed [TypeError]
               | GotType Value Type
               deriving (Eq)

instance Serializable TypeCheck where
    serialize (Screwed errors) = paragraph $ 0 >>>> errors
    serialize (GotType val typ) = serialize val ++ " : " ++ serialize typ


data TypeError  = TypeMismatch Value Type Type -- expected, got
                | NotInvocable Value -- got to be subprogram
                | SubprogramTypeError Value
                deriving (Eq, Ord)

instance Serializable TypeError where
    serialize (TypeMismatch v expected got) = paragraph $
            0 >>>> ["Type Mismatch: " ++ yellow (serialize $ getID v)]
        ++  1 >>>> ["expected: " ++ cyan (serialize expected)]
        ++  1 >>>> ["     got: " ++ cyan (serialize got)]
    serialize (NotInvocable v) = "Not Subprogram: " ++ yellow (serialize v)
    serialize (SubprogramTypeError v) = "Subprogram: " ++ yellow (serialize v)

instance Sym TypeError where
    getID (TypeMismatch v _ _) = getID v
    getID (NotInvocable v) = getID v
    getID (SubprogramTypeError v) = getID v
    getPos (TypeMismatch v _ _) = getPos v
    getPos (NotInvocable v) = getPos v
    getPos (SubprogramTypeError v) = getPos v
--------------------------------------------------------------------------------
-- functions on TypeCheck
(<->) :: TypeCheck -> TypeCheck -> TypeCheck
Screwed e   <-> Screwed f   = Screwed (e ++ f)
Screwed e   <-> GotType _ _ = Screwed e
GotType _ _ <-> Screwed e   = Screwed e
GotType x s <-> GotType y t | s == t = GotType y t
                            | s /= t = Screwed [TypeMismatch y s t]

(<=>) :: (Typeable a, Typeable b) => a -> b -> TypeCheck
a <=> b = typeCheck a <-> typeCheck b

--------------------------------------------------------------------------------
-- Typeable!

-- typeCheckInvocation :: Value -> [Expression Value] -> TypeCheck
-- typeCheckInvocation val params = check (getType val) (map typeCheck params)
--     where   check :: Type -> [Type] -> TypeCheck
--             check (Type prog) [] = GotType val (Type prog)
--             check (Type (x:xs)) (p:ps) = GotType val (Type prog)
-- typeCheckInvocation val []
--     | isVariable val = GotType val (getType val)
--     | otherwise = Screwed [SubprogramTypeError val]
-- typeCheckInvocation val (p:ps)
--     | higherOrder val && isVariable val = let Type (d:ds) = getType val in
--     | otherwise       = Screwed [SubprogramTypeError val]

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
    typeCheck (VariableFactor a) = typeCheck a
    typeCheck (InvocationFactor a es) = typeCheck a -- typeCheckInvocation a
    typeCheck (NumberFactor e) = typeCheck e
    typeCheck (SubFactor e) = typeCheck e
    typeCheck (NotFactor e) = typeCheck e

instance Typeable Value where
    typeCheck v@(Variable _ (Declaration _ t)) = GotType v t
    typeCheck v@(IntLiteral _ _)               = GotType v (BasicType IntType)
    typeCheck v@(RealLiteral _ _)              = GotType v (BasicType RealType)

--------------------------------------------------------------------------------

toResult :: TypeCheck -> Maybe [TypeError]
toResult (Screwed es)  = Just es
toResult (GotType _ _) = Nothing

collectResult :: [Maybe [TypeError]] -> Maybe [TypeError]
collectResult = fmap concat . sequence

typeCheckStmt :: Statement Value -> Maybe [TypeError]
typeCheckStmt (Assignment v e)  = toResult (v <=> e)
typeCheckStmt (Return e)        = toResult (typeCheck e)
typeCheckStmt (Invocation v es) = toResult (typeCheck v)
typeCheckStmt (Compound ss)     = collectResult (map typeCheckStmt ss)
typeCheckStmt (Branch e s t)    = collectResult [toResult (typeCheck e), typeCheckStmt s, typeCheckStmt t]
typeCheckStmt (Loop e s)        = collectResult [toResult (typeCheck e), typeCheckStmt s]

typeCheckStatement :: Statement Value -> [TypeError]
typeCheckStatement = concat . maybeToList . typeCheckStmt
