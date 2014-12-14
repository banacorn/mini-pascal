module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Compiler.Serialize
import Compiler.Scope
import Compiler.Types

import Control.Monad.Error
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
    result <- runErrorT pipeline
    case result of
        Left    err -> print err
        Right   src -> print src


pipeline = readSource "./test/scanner/scanner-test01.p" >>= scan


-- main :: IO ()
-- main = do
--     source <- testOne
--     let parseTree = parse (scan source)
--     print parseTree
--     draw . head $ getScope parseTree
--     draw parseTree
--
-- draw :: Serializable a => a -> IO ()
-- draw = putStrLn . serialize
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
