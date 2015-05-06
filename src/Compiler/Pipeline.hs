module Compiler.Pipeline where

import Compiler.Type.Pipeline
import Compiler.Semantics
import Compiler.Serializable
import Compiler.Syntax.Type


import              Compiler.AST
import              Compiler.AST.Type
import              Compiler.Semantics
import              Compiler.TypeCheck

import              Control.Exception (try, IOException)
import              Control.Monad.Except
import              Control.Monad.State
import              Data.Maybe (fromJust)
import              Data.List (intercalate, sort)
import              Data.Set (Set, toList)
import              System.Environment (getArgs)
import              System.Console.ANSI

--------------------------------------------------------------------------------
-- get path from command argument
--      Exception: throws FileError if argument not given
getPath :: Pipeline String
getPath = do
    args <- liftIO getArgs
    case args of
        []      -> throwError CommandLineErrorClass
        (x:_)   -> return x


--------------------------------------------------------------------------------
-- read source from file
--      Exception: throws FileError if file not found
--      State: saves source if possible

readSource :: String -> Pipeline String
readSource path = do
    result <- liftIO $ try (readFile path) :: Pipeline (Either IOException String)
    case result of
        Left  _ -> throwError FileErrorClass
        Right s -> do
            updateFileState (Just s) (Just path)
            return s


--------------------------------------------------------------------------------
--      Exception: Declaration Duplicated or Variable Undeclared

checkBinding :: RawAST -> Pipeline ABT
checkBinding rawAST = do
    let adt = toADT rawAST

    checkSemanticsError $ do
        checkDeclarationDuplicated adt
        checkVariableUndeclared adt

    -- the ADT is good enough to build ABT
    return (toABT rawAST adt)

--------------------------------------------------------------------------------
--      Exception: all sorts of TypeErrors

checkType :: ABT -> Pipeline ABT
checkType abt = do
    checkSemanticsError $ do
        checkTypeError abt
    return abt

--------------------------------------------------------------------------------
-- helper functions
--------------------------------------------------------------------------------

testWithSource :: String -> Pipeline String
testWithSource input = do
    updateFileState (Just input) (Just "interactive")
    return input

updateFileState :: Maybe String -> Maybe String -> Pipeline ()
updateFileState source path = modify $ \state -> state
    { zustandFilePath = path
    , zustandFileSource = source
    }

-- stores the error in der Zustand
throwSemanticsError :: SemanticsError -> Pipeline ()
throwSemanticsError err = do
    errors <- gets zustandSemanticsError
    modify $ \state -> state
        { zustandSemanticsError = err : errors }


checkDeclarationDuplicated :: ADT -> Pipeline ()
checkDeclarationDuplicated adt = case declarationDuplicated adt of
    [] -> return ()
    xs -> throwSemanticsError (SemDeclarationDuplicated xs)

checkVariableUndeclared :: ADT -> Pipeline ()
checkVariableUndeclared adt = case variableUndeclared adt of
    [] -> return ()
    xs -> throwSemanticsError (SemVariableUndeclared xs)

checkTypeError :: ABT -> Pipeline ()
checkTypeError abt = case typeCheck abt of
    [] -> return ()
    xs -> throwSemanticsError (SemTypeError xs)

--------------------------------------------------------------------------------
-- Diagnose and report errors
--------------------------------------------------------------------------------


checkSemanticsError :: Pipeline () -> Pipeline ()
checkSemanticsError f = do
    f
    errors <- gets zustandSemanticsError
    case errors of
        [] -> return () -- no semantics error
        xs -> throwError SemanticsErrorClass

pipeline :: Pipeline () -> IO ()
pipeline f = do
    (result, state) <- runStateT (runExceptT (checkSemanticsError f)) (Zustand Nothing Nothing [])
    case result of
        Left err -> mapM_ (putStrLn . serialize) (diagnoseError state err)
        Right () -> return ()

--------------------------------------------------------------------------------
-- Diagnose and report errors
--------------------------------------------------------------------------------
diagnoseError :: Zustand -> ErrorClass -> [Error]
diagnoseError (Zustand Nothing _ _) _ = [InvalidArgument]
diagnoseError (Zustand (Just path) Nothing _) _ = [NoSuchFile path]
diagnoseError (Zustand (Just path) _ _) FileErrorClass = [NoSuchFile path]
diagnoseError (Zustand (Just path) (Just src) _) (SyntaxErrorClass (Just (Token (TokError tok) pos))) = [LexError path src tok pos]
diagnoseError (Zustand (Just path) (Just src) _) (SyntaxErrorClass (Just (Token tok pos))) = [ParseError path src tok pos]
diagnoseError (Zustand (Just path) (Just src) _) (SyntaxErrorClass Nothing) = [NotEnoughInput path src]
diagnoseError (Zustand (Just path) (Just src) err) SemanticsErrorClass = diagnoseSemanticsError path src (sort err)
diagnoseError (Zustand (Just path) (Just src) err) (CompileErrorClass str) = [LLVMError str]

diagnoseSemanticsError :: FilePath -> Source -> [SemanticsError] -> [Error]
diagnoseSemanticsError path src [] = []
diagnoseSemanticsError path src (SemDeclarationDuplicated ps : xs) = map (DeclarationDuplicatedError path src) ps ++ diagnoseSemanticsError path src xs
diagnoseSemanticsError path src (SemVariableUndeclared ps : xs) = map (VariableUndeclaredError path src) ps ++ diagnoseSemanticsError path src xs
diagnoseSemanticsError path src (SemTypeError ps : xs) = map (TypeCheckError path src) ps ++ diagnoseSemanticsError path src xs


--------------------------------------------------------------------------------
-- Helper functions
--------------------------------------------------------------------------------
printIt :: Serializable a => a -> Pipeline ()
printIt = liftIO . putStrLn . serialize

printIt' :: Serializable a => a -> Pipeline a
printIt' a = do
    printIt a
    return a
