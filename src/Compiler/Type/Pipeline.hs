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

type Pipeline = ExceptT PipelineError (StateT Zustand IO)

--------------------------------------------------------------------------------
-- Compile Errors

-- semantics errors are collected in Zustand
data PipelineError  = FileError String
                    | ParseError (Maybe Token)
                    | SemanticsErrorFlag
                    deriving (Eq)

data SemanticsError = DeclarationDuplication [[Symbol]]
    deriving (Eq, Show)

instance Show PipelineError where
    show (FileError e) = "File Error: \n"
        ++ e
    show (ParseError msg) = "Parse Error: \n"
        ++ show msg
    show SemanticsErrorFlag = "Semantics Error"
