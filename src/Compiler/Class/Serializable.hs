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

instance Serializable a => Serializable [a] where
    serialize xs = "[" ++ intercalate ", " (map serialize xs) ++ "]"

instance Serializable String where
    serialize = id

instance Serializable () where
    serialize _ = ""
