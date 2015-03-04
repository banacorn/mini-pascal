module Compiler.Syntax.Type.Position where

import Compiler.Class.Serializable

import Data.Monoid

--------------------------------------------------------------------------------
-- Position
--------------------------------------------------------------------------------

data Position = Position
    {   posOffset :: Int
    ,   posLength :: Int
    ,   posLine :: Int
    ,   posColumn :: Int
    } | Unknown
    deriving (Eq)

instance Show Position where
    show (Position offset len line column) = "Position " ++ show offset ++ " " ++ show len ++ " L"++ show line ++ " C" ++ show column
    show Unknown = "Unknown"

instance Serializable Position where
    serialize Unknown = "?"
    serialize (Position o n l c) = show l ++ ":" ++ show c

instance Monoid Position where
    mempty = Unknown
    Position o n l c `mappend` Position o' n' _ _ = Position o (o' - o + n') l n

-- imagine Unknown as infinitely big Position
instance Ord Position where
    Unknown `compare` Unknown = EQ
    Unknown `compare` _       = GT
    _       `compare` Unknown = LT
    Position o _ _ _ `compare` Position o' _ _ _ = o `compare` o'
