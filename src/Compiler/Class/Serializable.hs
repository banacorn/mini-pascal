{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}

module Compiler.Class.Serializable where

class Serializable a where
    serialize :: a -> String

instance Serializable String where
    serialize = id

indentBlock :: String -> String
indentBlock str = map addNewLine (lines str) >>= (++) (replicate 4 ' ')

indentWith :: Serializable a => (String -> String) -> [a] -> String
indentWith f xs = indentBlock (xs >>= f . serialize)

indent :: Serializable a => [a] -> String
indent = indentWith addNewLine

suffix :: String -> String -> String
suffix s x = x ++ s

addNewLine :: String -> String
addNewLine = suffix "\n"