module Compiler.Type.ABT where

import Compiler.Type.Symbol

data Program = Program
    [Declaration]
    [Subprogram]
    [Statement]

data Subprogram = Subprogram
    [Declaration]
    [Statement]

data Statement  = Assignment Assignee Expression
                | Invocation Variable [Expression]
                | Compound [Statement]
                | Branch Expression Statement Statement
                | Loop Expression Statement

data Assignee = Assignee Variable [Expression]

data Expression = UnaryExpression SimpleExpression
                | BinaryExpression SimpleExpression RelOp SimpleExpression

data SimpleExpression = TermSimpleExpression Term
                      | OpSimpleExpression SimpleExpression AddOp Term

data Term = FactorTerm Factor
          | OpTerm Term MulOp Factor
          | NegTerm Factor

data Factor = ArrayAccessFactor Variable [Expression]
            | InvocationFactor  Variable [Expression]
            | NumberFactor      Literal
            | SubFactor         Expression
            | NotFactor         Factor

data AddOp = Plus | Minus
data MulOp = Mul | Div
data RelOp = S | L | E | NE | SE | LE
