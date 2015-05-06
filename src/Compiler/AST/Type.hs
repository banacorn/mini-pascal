module Compiler.AST.Type where

--------------------------------------------------------------------------------
--  Symbols
--------------------------------------------------------------------------------

data Literal = Literal Int
data Binding = Declaration | Local | Global
data Variable = Variable String Binding

--------------------------------------------------------------------------------
--  Expression
--------------------------------------------------------------------------------

data Expression = UnaryExpression SimpleExpression
                | BinaryExpression SimpleExpression RelOp SimpleExpression

data SimpleExpression = TermSimpleExpression Term
                      | OpSimpleExpression SimpleExpression AddOp Term

data Term = FactorTerm Factor
          | OpTerm Term MulOp Factor
          | NegTerm Factor

data Factor = VariableFactor    Variable
            | LiteralFactor     Literal
            | InvocationFactor  Variable [Expression]   -- id()
            | SubFactor         Expression              -- (...)
            | NotFactor         Factor                  -- -id

data AddOp = Plus | Minus
data MulOp = Mul | Div
data RelOp = S | L | E | NE | SE | LE


--------------------------------------------------------------------------------
--  Statement
--------------------------------------------------------------------------------

data Statement  = Assignment Variable
                | Return Expression
                | Invocation Variable Expression
                | Compound [Statement]
                | Branch Expression Statement Statement
                | Loop Expression Statement

--------------------------------------------------------------------------------
--  Program
--------------------------------------------------------------------------------

data Function = Function String Bool [Variable] [Statement]
data Program = Program [Variable] [Function]
