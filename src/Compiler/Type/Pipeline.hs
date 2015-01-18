module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Compiler.Type.Symbol
import Control.Monad.Except
import Control.Monad.State

--------------------------------------------------------------------------------
-- State of the compilation process
type Source = String
data Zustand = Zustand
    {   zustandFileSource :: Maybe Source
    ,   zustandFilePath :: Maybe FilePath
    ,   zustandSemanticsError :: [SemanticsError]
    }
type Pipeline = ExceptT ErrorClass (StateT Zustand IO)

--------------------------------------------------------------------------------
-- Compile Errors

-- indicates error class
-- semantics errors are collected in Zustand
data ErrorClass = CommandLineErrorClass
                | FileErrorClass
                | SyntaxErrorClass (Maybe Token)
                | SemanticsErrorClass
                deriving (Eq)

data PipelineError  = InvalidArgument           -- EINVAL
                    | NoSuchFile FilePath       -- ENOENT
                    | NotEnoughInput FilePath Source
                    | LexError FilePath Source String Position
                    | ParseError FilePath Source Tok Position
                    | DeclarationDuplicationError FilePath Source [Symbol]
                    deriving Show

data SemanticsError = DeclarationDuplication [[Symbol]]
    deriving (Eq, Show)
