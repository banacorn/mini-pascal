{-# LANGUAGE DeriveFunctor #-}

module Compiler.PreAST.Type.Expression where

import Compiler.Serializable
import Compiler.PreAST.Type.Symbol

--------------------------------------------------------------------------------
-- Expression (with >/>=/=....)
data Expression a = UnaryExpression (SimpleExpression a)
                  | BinaryExpression (SimpleExpression a) RelOp (SimpleExpression a)
                  deriving Functor

instance (Serializable a, Sym a) => Serializable (Expression a) where
    serialize (UnaryExpression e) = serialize e
    serialize (BinaryExpression a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b


--------------------------------------------------------------------------------
-- Simple Expression (with +/-)
data SimpleExpression a = TermSimpleExpression (Term a)
                        | OpSimpleExpression (SimpleExpression a) AddOp (Term a)
                        deriving Functor

instance (Serializable a, Sym a) => Serializable (SimpleExpression a) where
    serialize (TermSimpleExpression t) = serialize t
    serialize (OpSimpleExpression a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b


--------------------------------------------------------------------------------
-- Term (with *//)
data Term a = FactorTerm (Factor a)
            | OpTerm (Term a) MulOp (Factor a)
            | NegTerm (Factor a)
            deriving Functor

instance (Serializable a, Sym a) => Serializable (Term a) where
    serialize (FactorTerm f) = serialize f
    serialize (OpTerm a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
    serialize (NegTerm f) = "-" ++ serialize f


--------------------------------------------------------------------------------
-- Factor (basic building block)
data Factor a = VariableFactor    a
              | NumberFactor      Value
              | InvocationFactor  a [Expression a]     -- id()
              | SubFactor         (Expression a)       -- (...)
              | NotFactor         (Factor a)           -- -id
              deriving Functor

instance (Serializable a, Sym a) => Serializable (Factor a) where
    serialize (VariableFactor sym) = serialize sym
    serialize (InvocationFactor sym exprs)  = serialize sym ++ "(" ++ exprs' ++ ")"
        where   exprs' = intercalate' ", " exprs
    serialize (NumberFactor s) = serialize s
    serialize (SubFactor e) = "(" ++ serialize e ++ ")"
    serialize (NotFactor f) = "not " ++ serialize f


--------------------------------------------------------------------------------
-- Operators
data AddOp = Plus | Minus
data MulOp = Mul | Div
data RelOp = S | L | E | NE | SE | LE


instance Serializable AddOp where
    serialize Plus = "+"
    serialize Minus = "-"

instance Serializable MulOp where
    serialize Mul = "*"
    serialize Div = "/"

instance Serializable RelOp where
    serialize S = "<"
    serialize L = ">"
    serialize E = "="
    serialize NE = "!="
    serialize SE = "<="
    serialize LE = ">="
