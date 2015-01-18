module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Compiler.Type.Symbol
import Control.Monad.Except
import Control.Monad.State

-- Pipeline
data FileState = FileState
    {   fileSource :: Maybe String
    ,   filePath :: String
    } | NoFileState

type Pipeline = ExceptT PipelineError (StateT FileState IO)

data PipelineError  = FileError String
                    | ParseError (Maybe Token)
                    | SemanticsError SemanticsErrorType
                    deriving (Eq)

data SemanticsErrorType = DeclarationDuplication [[Symbol]]
    deriving (Eq, Show)

instance Show PipelineError where
    show (FileError e) = "File Error: \n"
        ++ e
    show (ParseError msg) = "Parse Error: \n"
        ++ show msg
    show (SemanticsError e) = show e
