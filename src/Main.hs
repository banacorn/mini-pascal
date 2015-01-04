module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Class.Serializable
import Compiler.Class.Scope
import Compiler.Type

import Control.Monad.Except
import Control.Monad.State
import Control.Exception (try, IOException)
import Data.List (intercalate)
import System.Environment (getArgs)


throw :: PipelineError -> Pipeline a
throw = throwError

getPath :: Pipeline String
getPath = do
    args <- liftIO getArgs
    case args of
        []      -> throw $ FileError "no input file"
        (x:_)   -> return x

readSource :: String -> Pipeline String
readSource path = do
    result <- liftIO $ try (readFile path) :: Pipeline (Either IOException String)
    case result of
        Left  _ -> throwError $ FileError $ "input file " ++ path ++ " does not exists"
        Right s -> return s

main :: IO ()
main = do
    (result, pos) <- runStateT (runExceptT pipeline) Unknown
    case result of
        Left    err -> print err
        Right   src -> putStrLn "== SUCCESS =="


pipeline = do
    -- read source, throw FileError if file not found
    source <- readSource "./test/parser/no-parsing-error/parser-test.p"
    ast <- scan "0progra" >>= parse
    -- draw ast
    draw . head $ getScope ast


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
--
-- pipeline :: String -> IO ()
-- pipeline = print . getScope . parse . scan
--
-- testOne :: IO String
-- testOne = readFile "./test/semantics/test-duplicate.p"
--
-- testAll :: IO ()
-- testAll = mapM_ run filenames
--     where
--         run s = readFile (pathPrefix ++ s) >>= pipeline
--         pathPrefix = "./test/parser/no-parsing-error/"
--         filenames =
--             [   "parser-test.p"
--             ,   "test-constant.p"
--             ,   "test-recursion.p"
--             ,   "test02-uninitialized-var.p"
--             ,   "test-operator.p"
--             ,   "test-operator2.p"
--             ,   "test00-runtime-range-check.p"
--             ,   "test04.p"
--             ,   "test-function.p"
--             ,   "test-procedure.p"
--             ,   "test01-global-var.p"
--             ]
