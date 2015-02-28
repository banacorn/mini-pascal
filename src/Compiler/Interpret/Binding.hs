module Compiler.Interpret.Binding where

import Compiler.Type
-- import Compiler.Interpret.Type

--------------------------------------------------------------------------------
-- Class & Instances of HasBinding

-- buildBindingTree :: [EqClass Declaration] -> Scope Occurrence -> Scope Binding
-- buildBindingTree decs occurs =

-- class HasBinding a where
--     getBinding :: [EqClass Declaration] -> a -> Scope Occurrence -> Scope Binding
--
-- instance HasBinding ProgramNode where
--     getBinding decs (ProgramNode sym _ _ subprogs stmts) = Scope scopeType subScopes []
--         where
--             scopeType = ProgramScope (fst sym)
--             subScopes = map getBinding getBinding ++ [getBinding stmts]
--
-- -- Program Declaration
-- data ProgramNode =
--     ProgramNode
--         SymbolNode          -- program name
--         [SymbolNode]        -- program arguments
--         [VarDecNode]        -- variable declarations
--         [SubprogDecNode]    -- subprogram declarations
--         CompoundStmtNode    -- compound statement
--     deriving (Eq, Show)
