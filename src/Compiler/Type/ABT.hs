module Compiler.Type.ABT where

import Compiler.Type.Symbol

data Program = Program
    [Declaration]
    [Subprogram]
    [Statement]

data Subprogram = Subprogram
    [Declaration]
    [Statement]

data Statement  = Assignment Variable Expression
                | Invocation Occurrence [Expression]
                | Compound [Statement]
                | Branch Expression Statement Statement
                | Loop Expression Statement

data Variable = Variable Occurrence [Expression]

data Expression = UnaryExpression SimpleExpression
                | BinaryExpression SimpleExpression RelOp SimpleExpression

data SimpleExpression = TermSimpleExpression Term
                      | OpSimpleExpression SimpleExpression AddOp Term

data Term = FactorTerm Factor
          | OpTerm Term MulOp Factor
          | NegTerm Factor

data Factor = ArrayAccessFactor Occurrence [Expression]
            | InvocationFactor  Occurrence [Expression]
            | NumberFactor      Number
            | SubFactor         Expression
            | NotFactor         Factor

data Number = IntNum Int
            | RealNum Double

data AddOp = Plus | Minus
data MulOp = Mul | Div
data RelOp = S | L | E | NE | SE | LE
