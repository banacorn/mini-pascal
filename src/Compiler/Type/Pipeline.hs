module Compiler.Type.Pipeline where

import Compiler.Type.Token
import Compiler.Type.Symbol
import Compiler.Class.Serializable

import Control.Monad.Except
import Control.Monad.State


import              Data.List (sort)
import              Data.Set (Set)
import qualified    Data.Set as Set

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
                    | VariableUndeclaredError FilePath Source Symbol

instance Serializable PipelineError where
    serialize InvalidArgument =  paragraphPadded $
            0 >>>> ["invalid argument"]
    serialize (NoSuchFile path) = paragraphPadded $
            0 >>>> ["no such path: " ++ yellow path]
    serialize (NotEnoughInput path src) = paragraphPadded $
            0 >>>> [path ++ ":"]
        ++  1 >>>> ["Not enough input"]
    serialize (LexError path src tok pos) = paragraphPadded $
            0 >>>> [red "Unrecognizable token: " ++ yellow tok]
        ++  1 >>>> toCodeBlocks path src [pos]
    serialize (ParseError path src tok pos) = paragraphPadded $
            0 >>>> [red "Unable to parse " ++ yellow (serialize tok)]
        ++  1 >>>> toCodeBlocks path src [pos]
    serialize (DeclarationDuplicatedError path src partition) = paragraphPadded $
            0 >>>> [red "Declaration Duplicated: " ++ yellow (serialize name)]
        ++  1 >>>> codeBlocks
        where   partition' = sort (Set.toList partition)              -- sort declarations base on their position
                Declaration (Symbol name pos) typ = head partition'    -- get the foremost declaration
                markPosition declaration = path ++ ":" ++ serialize (symPos (decSymbol declaration))
                codeBlocks = toCodeBlocks path src (map (symPos . decSymbol) partition')
    serialize (VariableUndeclaredError path src (Symbol name pos)) = paragraphPadded $
            0 >>>> [red "Variable Undeclared: " ++ yellow (serialize name)]
        ++  1 >>>> codeBlocks
        where   codeBlocks = toCodeBlocks path src [pos]
        -- where   partition' = sort (toList partition)    -- sort declarations base on their position
        --         Declaration t i pos = head partition'    -- get the foremost declaration
        --         markPosition declaration = path ++ ":" ++ serialize (decPos declaration)

data SemanticsError = DeclarationDuplicated [Set Declaration]
                    | VariableUndeclared [Symbol]
                    deriving (Eq, Ord)

instance Serializable SemanticsError where
    serialize (DeclarationDuplicated decs) = "DeclarationDuplicated: " ++ serialize decs
    serialize (VariableUndeclared occs) = "VariableUndeclared: " ++ serialize occs

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

instance Serializable CodeBlock where
    serialize (CodeBlock path src positions (from, to)) = paragraphPadded $
            0 >>>> (map markPosition positions)
        ++  0 >>>> ["----------------------------------------------------------------"]
        ++  0 >>>> numberedLines
        where   markPosition pos = path ++ ":" ++ serialize pos
                colouredSource = colourSource 0 positions src
                markedLines = drop from (take to (lines colouredSource))


                numberedLines = zipWith (++) lineNumberStrs markedLines
                lineNumbers = [from + 1 .. to + 1]
                lineNumberStrs = map (dull . fillSpace . show) lineNumbers
                    where   widest = length (show (to + 1))     -- the longest line number
                            fillSpace s = replicate (widest - length s) ' ' ++ s ++ " "

                colourSource _ [] source = source
                colourSource i (Position o n _ _ : xs) source =
                    (pre ++ yellow mid) ++ colourSource (i + o + n) xs post
                    where   pre = take (o - i) source
                            mid = take n (drop (o - i) source)
                            post = drop n (drop (o - i) source)
