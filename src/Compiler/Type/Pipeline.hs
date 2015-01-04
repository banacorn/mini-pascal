module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Control.Monad.Except
import Control.Monad.State

-- Pipeline
type Pipeline = ExceptT PipelineError (StateT (Maybe String) IO)

data PipelineError  = FileError String
                    | LexError Token
                    | ParseError Token
                    | SemanticsError String
                    deriving (Eq)

instance Show PipelineError where
    show (FileError e) = "File Error: \n"
        ++ e
    show (LexError msg) = "Lex Error: \n"
        ++ show msg
    show (ParseError msg) = "Parse Error: \n"
        ++ show msg
    show (SemanticsError e) = e