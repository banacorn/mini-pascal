{-# LANGUAGE FlexibleInstances #-}

module Compiler.TypeCheck (typeCheckStatement, TypeError(..)) where

import Compiler.Syntax.Type
import Compiler.PreAST.Type
import Compiler.Serializable

import Data.Maybe

--------------------------------------------------------------------------------
--  Data Type
--------------------------------------------------------------------------------
data TypeCheck = Screwed [TypeError]
               | GotType Value Type
               deriving (Eq)

instance Serializable TypeCheck where
    serialize (Screwed errors) = paragraph $ 0 >>>> errors
    serialize (GotType val typ) = serialize val ++ " : " ++ serialize typ


data TypeError  = TypeMismatch Value Type Type -- expected, got
                | NotInvocable Value
                | FunctionArityError Value Int Int
                | FunctionTypeError Value
                deriving (Eq, Ord)

instance Serializable TypeError where
    serialize (TypeMismatch v expected got) = paragraph $
            0 >>>> ["Type Mismatch: " ++ yellow (serialize $ getID v)]
        ++  1 >>>> ["expected: " ++ cyan (serialize expected)]
        ++  1 >>>> ["     got: " ++ cyan (serialize got)]
    serialize (NotInvocable v) = "Not a function: " ++ yellow (serialize (getID v))
    serialize (FunctionArityError v expected got) = paragraph $
            0 >>>> ["Function arity wrong: " ++ yellow (serialize $ getID v)]
        ++  1 >>>> ["expected: " ++ cyan (serialize expected)]
        ++  1 >>>> ["     got: " ++ cyan (serialize got)]
    serialize (FunctionTypeError v) = "Function type mismatch: " ++ yellow (serialize (getID v))

instance Sym TypeError where
    getID (TypeMismatch v _ _) = getID v
    getID (NotInvocable v) = getID v
    getID (FunctionArityError v _ _) = getID v
    getID (FunctionTypeError v) = getID v
    getPos (TypeMismatch v _ _) = getPos v
    getPos (NotInvocable v) = getPos v
    getPos (FunctionArityError v _ _) = getPos v
    getPos (FunctionTypeError v) = getPos v


--------------------------------------------------------------------------------
-- Typeable
--------------------------------------------------------------------------------

typeCheckInvocation :: Value -> [Expression Value] -> TypeCheck
typeCheckInvocation val@(Variable sym (Declaration sym' t _)) args
    | not isFunc                                                 = Screwed [NotInvocable val]
    |     isFunc && not arityOK                                  = Screwed [FunctionArityError val funcArity argsNum]
    |     isFunc &&     arityOK && not argsOK                    = Screwed argsErrors
    |     isFunc &&     arityOK &&     argsOK && not argsMatched = Screwed [FunctionTypeError val]
    |     isFunc &&     arityOK &&     argsOK &&     argsMatched = GotType val (getReturnType t)
    where   isFunc = isFunction t

            funcArity = arity t
            argsNum = length args
            arityOK = funcArity == argsNum

            argsOK = all isNothing $ map (toError . typeCheck) args
            argsErrors = fromJust $ collectError (map (toError . typeCheck) args)

            argsTypes = catMaybes (map (toResult . typeCheck) args)
            funcTypes = let FunctionType ds = t in map BasicType ds
            argsMatched = all (uncurry (==)) (zip funcTypes argsTypes)

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
    typeCheck (InvocationFactor a es) = typeCheckInvocation a es
    typeCheck (NumberFactor e) = typeCheck e
    typeCheck (SubFactor e) = typeCheck e
    typeCheck (NotFactor e) = typeCheck e

instance Typeable Value where
    typeCheck v@(Variable _ (Declaration _ t _)) = GotType v t
    typeCheck v@(IntLiteral _ _)               = GotType v (BasicType IntType)
    typeCheck v@(RealLiteral _ _)              = GotType v (BasicType RealType)

--------------------------------------------------------------------------------
--  Functions
--------------------------------------------------------------------------------


(<->) :: TypeCheck -> TypeCheck -> TypeCheck
Screwed e   <-> Screwed f   = Screwed (e ++ f)
Screwed e   <-> GotType _ _ = Screwed e
GotType _ _ <-> Screwed e   = Screwed e
GotType x s <-> GotType y t | s == t = GotType y t
                            | s /= t = Screwed [TypeMismatch y s t]

(<=>) :: (Typeable a, Typeable b) => a -> b -> TypeCheck
a <=> b = typeCheck a <-> typeCheck b

toError :: TypeCheck -> Maybe [TypeError]
toError (Screwed es)  = Just es
toError (GotType _ _) = Nothing

toResult ::TypeCheck -> Maybe Type
toResult (Screwed _)  = Nothing
toResult (GotType v t) = Just t

collectError :: [Maybe [TypeError]] -> Maybe [TypeError]
collectError xs = case concat (map maybeToList xs) of
    [] -> Nothing
    xs -> Just (concat xs)

typeCheckStmt :: Statement Value -> Maybe [TypeError]
typeCheckStmt (Assignment v e)  = toError (v <=> e)
typeCheckStmt (Return e)        = toError (typeCheck e)
typeCheckStmt (Invocation v es) = toError (typeCheckInvocation v es)
typeCheckStmt (Compound ss)     = collectError (map typeCheckStmt ss)
typeCheckStmt (Branch e s t)    = collectError [toError (typeCheck e), typeCheckStmt s, typeCheckStmt t]
typeCheckStmt (Loop e s)        = collectError [toError (typeCheck e), typeCheckStmt s]

typeCheckStatement :: Statement Value -> [TypeError]
typeCheckStatement = concat . maybeToList . typeCheckStmt
