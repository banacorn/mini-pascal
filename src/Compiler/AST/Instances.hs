module Compiler.AST.Instances where

import Compiler.AST.Type
import Compiler.Serializable

instance Serializable Literal where
    serialize (Literal n) = show n

instance Serializable Variable where
    serialize (Variable label binding) = green label ++ " : " ++ serialize binding

instance Serializable Binding where
    serialize Declaration = "dec"
    serialize Local = "local"
    serialize Global = "global"

instance Serializable Program where
    serialize (Program decs funcs) = paragraph $
            0 >>>> ["\nGlobal Variable Declarations"]
        ++  1 >>>> decs
        -- ++  0 >>>> ["\nFunction Definitions:"]
        -- ++  1 >>>> funcs
    --
    -- instance (Serializable a, Serializable b) => Serializable (Subprogram a b) where
    --     serialize (Subprogram decs stmts) = paragraph $
    --             0 >>>> decs
    --         ++  0 >>>> ["----------------"]
    --         ++  0 >>>> stmts

--------------------------------------------------------------------------------
--  Serializable
--------------------------------------------------------------------------------
--
-- data Literal = Literal Int
-- data Binding = Declaration | Local | Global
-- data Variable = Variable String Binding
--
-- --------------------------------------------------------------------------------
-- --  Expression
-- --------------------------------------------------------------------------------
--
-- data Expression = UnaryExpression SimpleExpression
--                 | BinaryExpression SimpleExpression RelOp SimpleExpression
--
-- data SimpleExpression = TermSimpleExpression Term
--                       | OpSimpleExpression SimpleExpression AddOp Term
--
-- data Term = FactorTerm Factor
--           | OpTerm Term MulOp Factor
--           | NegTerm Factor
--
-- data Factor = VariableFactor    Variable
--             | LiteralFactor     Literal
--             | InvocationFactor  Variable [Expression]   -- id()
--             | SubFactor         Expression              -- (...)
--             | NotFactor         Factor                  -- -id
--
-- data AddOp = Plus | Minus
-- data MulOp = Mul | Div
-- data RelOp = S | L | E | NE | SE | LE
--
--
-- --------------------------------------------------------------------------------
-- --  Statement
-- --------------------------------------------------------------------------------
--
-- data Statement  = Assignment Variable
--                 | Return Expression
--                 | Invocation Variable Expression
--                 | Compound [Statement]
--                 | Branch Expression Statement Statement
--                 | Loop Expression Statement
--
-- --------------------------------------------------------------------------------
-- --  Program
-- --------------------------------------------------------------------------------
--
-- data Function = Function String Bool [Variable] [Statement]
-- data Program = Program [Variable] [Function]
