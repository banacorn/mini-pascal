module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Control.Monad.Except
import Control.Monad.State

-- Pipeline
type Pipeline = ExceptT PipelineError (StateT Position IO)

data PipelineError  = FileError String
                    | LexError Token
                    | ParseError String
                    | SemanticError String
                    deriving (Eq)

instance Show PipelineError where
    show (FileError e) = e
    show (LexError msg) = "Lex Error: \n"
        ++ show msg
    show (ParseError msg) = "Parse Error: \n"
        ++ msg
    show (SemanticError e) = e
