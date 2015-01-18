module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Compiler.Type.Symbol
import Control.Monad.Except
import Control.Monad.State

--------------------------------------------------------------------------------
-- State of the compilation process
data Zustand = Zustand
    {   zustandFileSource :: Maybe String
    ,   zustandFilePath :: Maybe String
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

data SemanticsError = DeclarationDuplication [[Symbol]]
    deriving (Eq, Show)
