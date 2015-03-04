{-# LANGUAGE FlexibleInstances #-}

module Compiler.TypeCheck (typeCheckStatement, TypeError(..)) where

import Compiler.Type.Symbol
import Compiler.Type.Type
import Compiler.Type.DSL
import Compiler.Class.Serializable

import Data.Maybe


--------------------------------------------------------------------------------
-- TypeCheck data type
data TypeCheck = Screwed [TypeError]
               | GotType Value Type
               deriving (Eq)


data TypeError  = TypeMismatch Value Type Type -- expected, got
                | ExpectArray Value  -- got to be array
                | NotInvocable -- got to be subprogram
                | IndexNotInt Value -- got to be all Int
                | SubprogramTypeError Value
                deriving (Eq, Ord)

instance Serializable TypeError where
    serialize (TypeMismatch v expected got) =
        "Type Mismatch: " ++ serialize v ++
        "\n    expected: " ++ serialize expected ++
        "\n         got: " ++ serialize got
    serialize (ExpectArray v) = "ExpectArray"
    serialize (NotInvocable) = "NotInvocable"
    serialize (IndexNotInt v) = "IndexNotInt"
    serialize (SubprogramTypeError v) = "SubprogramTypeError"

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


-- typeCheckArray :: Value -> [Expression Value] -> TypeCheck
-- typeCheckArray val indices
--     | not notSubprogram && not indicesChecked = Screwed [IndexNotInt val, ExpectArray val] 
--     |     notSubprogram && not indicesChecked = Screwed [IndexNotInt val]
--     | not notSubprogram &&     indicesChecked = Screwed [ExpectArray val]
--     |     notSubprogram &&     indicesChecked = let Type [domain] = arrayType in check domain indices
--     where   indicesChecked = all (gotTypeInt . typeCheck) indices
--             notSubprogram = firstOrder arrayType
--
--             gotTypeInt (GotType _ (Type [IntType])) = True
--             gotTypeInt _                            = False
--
--             arrayType = getType val
--
--             check _                         []     = GotType val arrayType
--             check (ArrayType (m, n) domain) (i:is) = check domain is
--             check _                         (i:is) = Screwed [ExpectArray val]

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

instance Typeable (Assignee Value) where
    typeCheck (Assignee v es) = typeCheck v

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
    typeCheck (ArrayAccessFactor a es) = typeCheck a -- typeCheckArray a es
    typeCheck (InvocationFactor a es) = typeCheck a -- typeCheckInvocation a
    typeCheck (NumberFactor e) = typeCheck e
    typeCheck (SubFactor e) = typeCheck e
    typeCheck (NotFactor e) = typeCheck e

instance Typeable Value where
    typeCheck v@(Variable _ (Declaration _ t)) = GotType v t
    typeCheck v@(IntLiteral _)                 = GotType v (Type [IntType])
    typeCheck v@(RealLiteral _)                = GotType v (Type [RealType])

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
