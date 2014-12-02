module Compiler.Serialize where

class Serializable a where
    serialize :: a -> String
