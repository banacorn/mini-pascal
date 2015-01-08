module Compiler.Pipeline where

import Compiler.Type
import Compiler.Class.Serializable

import Control.Exception (try, IOException)
import Control.Monad.Except
import Control.Monad.State
import Data.Maybe (fromJust)
import Data.List (intercalate)
import System.Environment (getArgs)
import System.Console.ANSI

getPath :: Pipeline String
getPath = do
    args <- liftIO getArgs
    case args of
        []      -> throwError $ FileError "no input file"
        (x:_)   -> return x

-- read source from file
-- Exception: throws FileError if file not found
-- State: saves source if possible
readSource :: String -> Pipeline String
readSource path = do
    result <- liftIO $ try (readFile path) :: Pipeline (Either IOException String)
    case result of
        Left  _ -> throwError $ FileError path
        Right s -> do
            put (Just s)
            return s

handleError :: Pipeline a -> IO ()
handleError f = do
    (result, source) <- runStateT (runExceptT f) Nothing
    case result of
        Left    err -> case err of
            FileError path -> do
                putStrLn $ paintError "[File Error]"
                putStrLn $ "Input file " ++ paintWarn path ++ " does not exists"
            LexError (Token (TokError tok) pos) -> do
                putStrLn $ paintError "[Syntax Error]"
                    ++ " Unrecognized token "
                    ++ paintWarn (serialize tok)
                    ++ " at L" ++ show (posLine pos) ++ " C" ++ show (posColumn pos)
                printSyntaxError (fromJust source) pos
            ParseError (Token tok pos) -> do
                putStrLn $ paintError "[Syntax Error]"
                    ++ " Unable to parse "
                    ++ paintWarn (serialize tok)
                    ++ "... starting from L" ++ show (posLine pos) ++ " C" ++ show (posColumn pos)
                printSyntaxError (fromJust source) pos
            SemanticsError _ -> print err

        Right   src -> return ()

    where
        paintError s = setSGRCode [SetColor Foreground Vivid Red] ++ s ++ setSGRCode []
        paintWarn s = setSGRCode [SetColor Foreground Vivid Yellow] ++ s ++ setSGRCode []


printSyntaxError :: String -> Position -> IO ()
printSyntaxError source (Position offset len l c) = do
    putStrLn ""
    putStrLn (unlines $ zipWith addLineNo lineNos reportLines)
    where   lineNo = l - 1
            columnNo = c - 1

            sourceBeforeError = take offset source
            sourceError = take (fromJust len) (drop offset source)
            sourceAfterError = drop (fromJust len) (drop offset source)
            source' = sourceBeforeError ++ paintError sourceError ++ sourceAfterError
            sourceLines = lines source'
            rangeFrom = (lineNo - 2) `max` 0
            rangeTo = (lineNo + 2) `min` length sourceLines
            reportLines = take (rangeTo - rangeFrom + 1) (drop rangeFrom sourceLines)
            leftPadding s = let s' = show s
                                w = length s'
                            in  replicate (length (show (rangeTo + 1)) - w) ' ' ++ s'
            lineNos = map (paintLineNo . leftPadding) [rangeFrom + 1 .. rangeTo + 1]
            addLineNo n l = n ++ " " ++ l


            paintError s = setSGRCode [SetColor Foreground Vivid Yellow] ++ s ++ setSGRCode []
            paintLineNo s = setSGRCode [SetColor Foreground Vivid Green] ++ s ++ setSGRCode []


-- main :: IO ()
-- main = do
--     source <- testOne
--     let parseTree = parse (scan source)
--     print parseTree
--     draw . head $ getScope parseTree
--     draw parseTree
--
draw :: Serializable a => a -> Pipeline ()
draw = liftIO . putStrLn . serialize