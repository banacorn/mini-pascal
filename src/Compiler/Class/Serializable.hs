{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, OverlappingInstances #-}
module Compiler.Class.Serializable where

-- import Compiler.Type hiding (Compiler.Type.Symbol)
import              Data.List (intercalate, sort)
import              Data.Set (Set, size, findMin, toList)
import qualified    Data.Set as Set
import              System.Console.ANSI

infixr 6 >>>>

class Serializable a where
    serialize :: a -> String

--------------------------------------------------------------------------------
-- DSL for indentation, deep-embedding

data Line   = Indent Line
            | Un String
data Paragraph = Paragraph [Line]

indentSize :: Int
indentSize = 4

instance Serializable Line where
    serialize (Indent   p) = replicate indentSize ' ' ++ serialize p
    serialize (Un p) = p

instance Serializable Paragraph where
    serialize (Paragraph ls) = intercalate' "\n" ls


paragraph :: [Line] -> String
paragraph = serialize . Paragraph

-- paragraph with top & bottom newline paddings
paragraphPadded :: [Line] -> String
paragraphPadded = serialize . Paragraph . addPadding
    where   addPadding xs = 0 >>>> [" "] ++ xs ++ 0 >>>> [" "]

indents :: Int -> String -> Line
indents 0 = Un
indents n = Indent . indents (n - 1)

-- indent list of Chunks
(>>>>) :: Serializable a => Int -> [a] -> [Line]
n >>>> xs = map (indents n) (map serialize xs >>= lines)

intercalate' :: Serializable a => String -> [a] -> String
intercalate' delimeter = intercalate delimeter . map serialize


compound :: Serializable a => [a] -> [Line]
compound stmts  =   0 >>>> ["begin"]
                ++  1 >>>> map serialize stmts
                ++  0 >>>> ["end"]

--------------------------------------------------------------------------------
-- colours!

cyan :: String -> String
cyan s = setSGRCode [SetColor Foreground Vivid Cyan] ++ s ++ setSGRCode []

green :: String -> String
green s = setSGRCode [SetColor Foreground Vivid Green] ++ s ++ setSGRCode []

yellow :: String -> String
yellow s = setSGRCode [SetColor Foreground Vivid Yellow] ++ s ++ setSGRCode []

red :: String -> String
red s = setSGRCode [SetColor Foreground Vivid Red] ++ s ++ setSGRCode []

dull :: String -> String
dull s = setSGRCode [SetColor Foreground Dull White] ++ s ++ setSGRCode []

--------------------------------------------------------------------------------
-- other instances


instance Serializable a => Serializable (Set a) where
    serialize set | size set == 0 = "{ }"
                  | size set == 1 = "{ " ++ serialize (findMin set) ++ " }"
                  | otherwise     = "{ " ++ serialize (findMin set) ++ " " ++ yellow "..." ++ " }"

instance Serializable String where
    serialize = id

instance Serializable a => Serializable [a] where
    serialize xs = "[" ++ intercalate ", " (map serialize xs) ++ "]"

-- instance Serializable ProgramNode where
--     serialize (ProgramNode sym params vars subprogs stmts) = paragraph $
--             0 >>>> [header]
--         ++  1 >>>> vars
--         ++  1 >>>> subprogs
--         ++  1 >>>> [stmts]
--         where
--             header = "program " ++ fst sym ++ "(" ++ paramList ++ ") ;"
--             paramList = intercalate' ", " (map fst params)
--
-- instance Serializable VarDecNode where
--     serialize (VarDecNode [] _) = ""
--     serialize (VarDecNode syms t) =
--         "var " ++ ids ++ " : " ++ serialize t ++ ";"
--         where
--             ids = intercalate' ", " (map fst syms)
--
-- instance Serializable TypeNode where
--     serialize (BaseTypeNode t) = serialize t
--     serialize (ArrayTypeNode (a, b) t) =
--         "array [ " ++ a ++ " .. " ++ b ++ " ] of " ++ serialize t
--
-- instance Serializable StandardTypeNode where
--     serialize IntTypeNode = "int"
--     serialize RealTypeNode = "real"
--     serialize StringTypeNode = "string"
--
-- instance Serializable SubprogDecNode where
--     -- function, no parameter
--     serialize (FuncDecNode sym [] typ vars stmts) = paragraph $
--             0 >>>> ["function " ++ fst sym ++ " : " ++ serialize typ ++ ";"]
--         ++  1 >>>> vars
--         ++  1 >>>> [stmts]
--     -- function, with parameters
--     serialize (FuncDecNode sym params typ vars stmts) = paragraph $
--             0 >>>> ["function " ++ fst sym ++ "(" ++ paramList ++ "): " ++ serialize typ ++ ";"]
--         ++  1 >>>> vars
--         ++  1 >>>> [stmts]
--         where   paramList = intercalate' ", " params
--     -- procedure, no paramter
--     serialize (ProcDecNode sym [] vars stmts) = paragraph $
--             0 >>>> ["procedure " ++ fst sym ++ ";"]
--         ++  1 >>>> vars
--         ++  1 >>>> [stmts]
--     -- procedure, with parameters
--     serialize (ProcDecNode sym params vars stmts) = paragraph $
--             0 >>>> ["function " ++ fst sym ++ "(" ++ paramList ++ ");"]
--         ++  1 >>>> vars
--         ++  1 >>>> [stmts]
--         where   paramList = intercalate' ", " params
--
--
-- instance Serializable ParameterNode where
--     serialize (ParameterNode syms t) = ids ++ ": " ++ serialize t
--         where   ids = intercalate' ", " (map fst syms)
--
-- instance Serializable CompoundStmtNode where
--     serialize (CompoundStmtNode stmts) = paragraph $
--             0 >>>> ["begin"]
--         ++  1 >>>> stmts
--         ++  0 >>>> ["end"]
-- instance Serializable StmtNode where
--     serialize (AssignStmtNode v e) = serialize v ++ " := " ++ serialize e
--     serialize (SubprogInvokeStmtNode sym []) = fst sym
--     serialize (SubprogInvokeStmtNode sym exprs) = fst sym ++ "(" ++ exprs' ++ ")"
--         where   exprs' = intercalate' ", " exprs
--     serialize (CompStmtNode stmts) = serialize stmts
--     serialize (BranchStmtNode e s t) = paragraph $
--             0 >>>> ["if " ++ serialize e]
--         ++  1 >>>> ["then " ++ serialize s]
--         ++  1 >>>> ["else " ++ serialize s]
--     serialize (LoopStmtNode e s) = paragraph $
--             0 >>>> ["while " ++ serialize e ++ " do"]
--         ++  1 >>>> [s]
--
-- instance Serializable VariableNode where
--     serialize (VariableNode sym es) = fst sym ++ (es >>= showArrayAccess)
--         where   showArrayAccess e = "[" ++ serialize e ++ "]"
--
