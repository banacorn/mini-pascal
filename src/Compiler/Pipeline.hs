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
    { zustandFilePath = path
    , zustandFileSource = source
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
checkDeclarationDuplication :: Scope Symbol -> Pipeline ()
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
        Left err -> mapM_ (putStrLn . serialize) (diagnoseError state err)
        Right () -> return ()

--------------------------------------------------------------------------------
-- Diagnose and refine errors
diagnoseError :: Zustand -> ErrorClass -> [PipelineError]
diagnoseError (Zustand Nothing _ _) _ = [InvalidArgument]
diagnoseError (Zustand (Just path) Nothing _) _ = [NoSuchFile path]
diagnoseError (Zustand (Just path) _ _) FileErrorClass = [NoSuchFile path]
diagnoseError (Zustand (Just path) (Just src) _) (SyntaxErrorClass (Just (Token (TokError tok) pos))) = [LexError path src tok pos]
diagnoseError (Zustand (Just path) (Just src) _) (SyntaxErrorClass (Just (Token tok pos))) = [ParseError path src tok pos]
diagnoseError (Zustand (Just path) (Just src) _) (SyntaxErrorClass Nothing) = [NotEnoughInput path src]
diagnoseError (Zustand (Just path) (Just src) err) SemanticsErrorClass = diagnoseSemanticsError path src err

diagnoseSemanticsError :: FilePath -> Source -> [SemanticsError] -> [PipelineError]
diagnoseSemanticsError path src [] = error "Semantics Error Class raised yet no semantics error found"
diagnoseSemanticsError path src (DeclarationDuplication ps : xs) = map (DeclarationDuplicationError path src) ps


draw :: Serializable a => a -> Pipeline ()
draw = liftIO . putStrLn . serialize
