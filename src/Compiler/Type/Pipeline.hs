module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Control.Monad.Except

-- Pipeline
type Pipeline = ExceptT PipelineError IO

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
