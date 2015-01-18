module Compiler.Pipeline where

import Compiler.Type
import Compiler.Semantics
import Compiler.Class.Serializable

import Control.Exception (try, IOException)
import Control.Monad.Except
import Control.Monad.State
import Data.Maybe (fromJust)
import Data.List (intercalate)
import System.Environment (getArgs)
import System.Console.ANSI

--------------------------------------------------------------------------------
-- get path from command argument
--  Exception: throws FileError if argument not given
getPath :: Pipeline String
getPath = do
    args <- liftIO getArgs
    case args of
        []      -> throwError CommandLineErrorClass
        (x:_)   -> return x

--------------------------------------------------------------------------------
-- read source from file
--  Exception: throws FileError if file not found
--  State: saves source if possible
readSource :: String -> Pipeline String
readSource path = do
    result <- liftIO $ try (readFile path) :: Pipeline (Either IOException String)
    case result of
        Left  _ -> throwError FileErrorClass
        Right s -> do
            updateFileState (Just s) (Just path)
            return s


--------------------------------------------------------------------------------
-- helper functions

testWithSource :: String -> Pipeline String
testWithSource input = do
    updateFileState (Just input) (Just "interactive")
    return input

updateFileState :: Maybe String -> Maybe String -> Pipeline ()
updateFileState source path = modify $ \state -> state
    { zustandFileSource = source
    , zustandFilePath = path
    }

-- stores the error in Zustand
throwSemanticsError :: SemanticsError -> Pipeline ()
throwSemanticsError err = do
    errors <- gets zustandSemanticsError
    modify $ \state -> state
        { zustandSemanticsError = err : errors }


--------------------------------------------------------------------------------
-- Semantics Checking: Declaration Duplication
--  Exception: throws SemanticsError if any declaration duplicated (implicitly)
--  State: saves SemanticsError if there's any
checkDeclarationDuplication :: Scope -> Pipeline ()
checkDeclarationDuplication scope = case declarationDuplications scope of
    [] -> return ()
    xs -> throwSemanticsError (DeclarationDuplication xs)

--------------------------------------------------------------------------------
-- Semantics Checking: ?
--  Exception: throws SemanticsError if any semantics error stored in der Zustand
checkSemantics :: Pipeline () -> Pipeline ()
checkSemantics f = do
    f
    errors <- gets zustandSemanticsError
    case errors of
        [] -> return () -- no semantics error
        xs -> throwError SemanticsErrorClass

pipeline :: Pipeline () -> IO ()
pipeline f = do
    (result, state) <- runStateT (runExceptT (checkSemantics f)) (Zustand Nothing Nothing [])
    case result of
        Left err -> return ()
            -- mapM_ (putStrLn . serialize) (diagnoseError state err)
            -- FileError path -> do
            --     putStrLn $ paintError "[File Error]"
            --     putStrLn $ "Input file " ++ paintWarn path ++ " does not exists"
            -- ParseError Nothing -> do
            --     putStrLn $ paintError "[Syntax Error]" ++ " " ++ path ++ printPos Unknown ++ "\n"
            --         ++ "Unable to parse, not enough input"
            -- ParseError (Just (Token (TokError tok) pos)) -> do
            --     putStrLn $ paintError "[Syntax Error]" ++ " " ++ path ++ printPos pos ++ "\n"
            --         ++ "Unrecognizable token "
            --         ++ paintWarn (serialize tok)
            --     printSyntaxError (fromJust source) pos
            -- ParseError (Just (Token tok pos)) -> do
            --     putStrLn $ paintError "[Syntax Error]" ++ " " ++ path ++ printPos pos ++ "\n"
            --         ++ "Unable to parse "
            --         ++ paintWarn (serialize tok)
            --     printSyntaxError (fromJust source) pos
            -- SemanticsErrorFlag -> do
            --     putStrLn $ paintError "[Semantics Error]" ++ path ++ "\n"
            --     print semErr
            --     -- mapM_ (printDeclarationDuplicationError path) partitions


        Right   () -> do
            return ()

    where
        printPos (Position o n l c) = ":" ++ show l ++ ":" ++ show c ++ ":"
        printPos Unknown = ""
        paintError s = setSGRCode [SetColor Foreground Vivid Red] ++ s ++ setSGRCode []
        paintWarn s = setSGRCode [SetColor Foreground Vivid Yellow] ++ s ++ setSGRCode []

        printDeclarationDuplicationError :: String -> [Symbol] -> IO ()
        printDeclarationDuplicationError path partition = do
            putStrLn $ path ++ "\n"



diagnoseError :: Zustand -> ErrorClass -> [PipelineError]
diagnoseError (Zustand _ Nothing _) _ = [InvalidArgument]
diagnoseError (Zustand Nothing (Just path) _) _ = [NoSuchFile path]
diagnoseError (Zustand _ (Just path) _) FileErrorClass = [NoSuchFile path]
diagnoseError (Zustand (Just src) (Just path) _) (SyntaxErrorClass (Just (Token (TokError tok) pos))) = [LexError path src tok pos]
diagnoseError (Zustand (Just src) (Just path) _) (SyntaxErrorClass (Just (Token tok pos))) = [ParseError path src tok pos]
diagnoseError (Zustand (Just src) (Just path) _) (SyntaxErrorClass Nothing) = [NotEnoughInput path src]
diagnoseError (Zustand (Just src) (Just path) err) SemanticsErrorClass = diagnoseSemanticsError path src err

diagnoseSemanticsError :: FilePath -> Source -> [SemanticsError] -> [PipelineError]
diagnoseSemanticsError path src [] = error "Semantics Error Class raised yet no semantics error found"
diagnoseSemanticsError path src (DeclarationDuplication ps : xs) = map (DeclarationDuplicationError path src) ps


printSyntaxError :: String -> Position -> IO ()
printSyntaxError source (Position offset len l c) = do
    putStrLn ""
    putStrLn (unlines $ zipWith addLineNo lineNos reportLines)
    where   lineNo = l - 1
            columnNo = c - 1

            sourceBeforeError = take offset source
            sourceError = take len (drop offset source)
            sourceAfterError = drop len (drop offset source)
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

draw :: Serializable a => a -> Pipeline ()
draw = liftIO . putStrLn . serialize
