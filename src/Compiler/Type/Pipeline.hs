module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Compiler.Type.Symbol
import Control.Monad.Except
import Control.Monad.State

import              Data.List (sort)
import              Data.Set (Set)

--------------------------------------------------------------------------------
-- State of the compilation process
type Source = String
data Zustand = Zustand
    {   zustandFilePath :: Maybe FilePath
    ,   zustandFileSource :: Maybe Source
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
                    | DeclarationDuplicatedError FilePath Source (Set Declaration)
                    | VariableUndeclaredError FilePath Source Occurrence

data SemanticsError = DeclarationDuplicated [Set Declaration]
                    | VariableUndeclared [Occurrence]
                    deriving (Eq, Ord)

data CodeBlock = CodeBlock
    {   codeBlockPath :: FilePath
    ,   codeBlockSource :: Source
    ,   codeBlockPositions :: [Position]
    ,   codeBlockRange :: (Int, Int)        -- Line n ~ Line m
    }   deriving Show


-- converts positions to code blocks
toCodeBlocks :: FilePath -> Source -> [Position] -> [CodeBlock]
toCodeBlocks path src ps = mergeCodeBlocks $ map (toCodeBlock path src) (sort ps)
    where
        toCodeBlock :: FilePath -> Source -> Position -> CodeBlock
        toCodeBlock path src Unknown = error "converting unknown position to Code Block"
        toCodeBlock path src pos@(Position o n l c) = CodeBlock path src [pos] (rangeFrom, rangeTo)
            where   sourceHeight = length (lines src)
                    radius = 2                                      -- range [n - range, n + range]
                    rangeFrom = (l - 1 - radius) `max` 0            -- don't go below 0
                    rangeTo   = (l + radius) `min` sourceHeight     -- don't go over the source

        -- merge Code Blocks if they are close to each other
        mergeCodeBlocks :: [CodeBlock] -> [CodeBlock]
        mergeCodeBlocks [] = []
        mergeCodeBlocks [CodeBlock p s pos (m, n)] = [CodeBlock p s pos (m, n)]
        mergeCodeBlocks (CodeBlock p s pos (m, n) : CodeBlock p' s' pos' (m', n') : xs)
            | n >= m' && p == p' && s == s' = CodeBlock p s (pos ++ pos') (m, n') : mergeCodeBlocks xs -- overlap
            | otherwise = CodeBlock p s pos (m, n ) : CodeBlock p' s' pos' (m', n') : mergeCodeBlocks xs
