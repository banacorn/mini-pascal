module Compiler.Type.Pipeline where

import Compiler.AST.Type
import Compiler.Syntax.Type
import Compiler.Serializable
import Compiler.TypeCheck

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
                | CompileErrorClass String
                deriving (Eq, Show)

data Error  = InvalidArgument           -- EINVAL
            | NoSuchFile FilePath       -- ENOENT
            | NotEnoughInput FilePath Source
            | LexError FilePath Source String Position
            | ParseError FilePath Source Tok Position
            | DeclarationDuplicatedError FilePath Source (Set Declaration)
            | VariableUndeclaredError FilePath Source Symbol
            | TypeCheckError FilePath Source TypeError
            | LLVMError String

instance Serializable Error where
    serialize InvalidArgument =  paragraphPadded $
            0 >>>> ["invalid argument"]
    serialize (NoSuchFile path) = paragraphPadded $
            0 >>>> ["no such path: " ++ yellow path]
    serialize (NotEnoughInput path src) = paragraphPadded $
            0 >>>> [path ++ ":"]
        ++  1 >>>> ["Not enough input"]
    serialize (LexError path src tok pos) = paragraphPadded $
            0 >>>> [red "Unrecognizable token: " ++ yellow tok]
        ++  1 >>>> toCodeMaps path src [pos]
    serialize (ParseError path src tok pos) = paragraphPadded $
            0 >>>> [red "Unable to parse " ++ yellow (serialize tok)]
        ++  1 >>>> toCodeMaps path src [pos]
    serialize (DeclarationDuplicatedError path src partition) = paragraphPadded $
            0 >>>> [red "Declaration Duplicated: " ++ yellow (serialize name)]
        ++  1 >>>> codeMaps
        where   partition' = sort (Set.toList partition)              -- sort declarations base on their position
                Declaration (Symbol name pos) typ = head partition'    -- get the foremost declaration
                markPosition declaration = path ++ ":" ++ serialize (symPos (decSymbol declaration))
                codeMaps = toCodeMaps path src (map (symPos . decSymbol) partition')
    serialize (VariableUndeclaredError path src (Symbol name pos)) = paragraphPadded $
            0 >>>> [red "Variable Undeclared: " ++ yellow (serialize name)]
        ++  1 >>>> codeMaps
        where   codeMaps = toCodeMaps path src [pos]
    serialize (TypeCheckError path src typeError) = paragraphPadded $
            0 >>>> [red "Type Error: " ++ serialize typeError]
        ++  1 >>>> codeMaps
        where   pos = getPos typeError
                codeMaps = toCodeMaps path src [pos]
    serialize (LLVMError str) = paragraphPadded $
            0 >>>> [red "LLVM error: " ++ yellow str]
data SemanticsError = SemDeclarationDuplicated [Set Declaration]
                    | SemVariableUndeclared [Symbol]
                    | SemTypeError [TypeError]
                    deriving (Eq, Ord)

instance Serializable SemanticsError where
    serialize (SemDeclarationDuplicated decs) = "DeclarationDuplicated: " ++ serialize decs
    serialize (SemVariableUndeclared syms) = "VariableUndeclared: " ++ serialize syms
    serialize (SemTypeError errs) = "TypeError: " ++ serialize errs

--------------------------------------------------------------------------------
-- Code Map
--------------------------------------------------------------------------------

data CodeMap = CodeMap
    {   codeMapPath :: FilePath
    ,   codeMapSource :: Source
    ,   codeMapPositions :: [Position]
    ,   codeMapRange :: (Int, Int)        -- Line n ~ Line m
    }   deriving Show


-- converts positions to code maps
toCodeMaps :: FilePath -> Source -> [Position] -> [CodeMap]
toCodeMaps path src ps = mergeCodeMaps $ map (toCodeMap path src) (sort ps)
    where
        toCodeMap :: FilePath -> Source -> Position -> CodeMap
        toCodeMap path src Unknown = error "converting unknown position to Code Map"
        toCodeMap path src pos@(Position o n l c) = CodeMap path src [pos] (rangeFrom, rangeTo)
            where   sourceHeight = length (lines src)
                    radius = 2                                      -- range [n - range, n + range]
                    rangeFrom = (l - 1 - radius) `max` 0            -- don't go below 0
                    rangeTo   = (l + radius) `min` sourceHeight     -- don't go over the source

        -- merge Code blocks if they are close to each other
        mergeCodeMaps :: [CodeMap] -> [CodeMap]
        mergeCodeMaps [] = []
        mergeCodeMaps [CodeMap p s pos (m, n)] = [CodeMap p s pos (m, n)]
        mergeCodeMaps (CodeMap p s pos (m, n) : CodeMap p' s' pos' (m', n') : xs)
            | n >= m' && p == p' && s == s' = CodeMap p s (pos ++ pos') (m, n') : mergeCodeMaps xs -- overlap
            | otherwise = CodeMap p s pos (m, n ) : CodeMap p' s' pos' (m', n') : mergeCodeMaps xs

instance Serializable CodeMap where
    serialize (CodeMap path src positions (from, to)) = paragraphPadded $
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
