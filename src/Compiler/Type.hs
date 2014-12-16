module Compiler.Type
    (   module Compiler.Type.AST
    ,   Depth
    ,   Symbol
    ,   SymbolTable
    ,   Scope(..)
    ,   Pipeline(..)
    ,   Position(..)
    ,   PipelineError(..)
    ) where

import Control.Monad.Except
import Data.List (intercalate)

-- import Compiler.Class.Serializable
-- import Compiler.Class.Scope
import Compiler.Type.AST

type Depth = Int
type Symbol = String
type SymbolTable = [(Symbol, Depth)]

data Scope  = Scope String [Symbol] [Scope]
    deriving (Eq, Show)


-- Pipeline
type Pipeline = ExceptT PipelineError IO

data Position = Position {
        posOffset :: Int
    ,   posLine :: Int
    ,   posColumn :: Int
    }
    deriving (Eq)

instance Show Position where
    show (Position offset line column) = "Position " ++ show offset ++ " " ++ show line ++ " " ++ show column
--         "@ " ++ show offset
--         ++ " L " ++ show line
--         ++ " C " ++ show column

data PipelineError  = FileError String
                    | LexError Position String
                    | ParseError Position String
                    | SemanticError String
                    deriving (Eq)
instance Show PipelineError where
    show (FileError e) = e
    show (LexError pos msg) = "Lex Error: \n"
        ++ show pos ++ "\n"
        ++ msg
    show (ParseError pos msg) = "Lex Error: \n"
        ++ show pos ++ "\n"
        ++ msg
    show (SemanticError e) = e
