module Compiler.PreAST.Type
    (   module Compiler.PreAST.Type.Expression
    ,   module Compiler.PreAST.Type.Statement
    ,   module Compiler.PreAST.Raw.Type
    ,   module Compiler.PreAST.Type.Symbol
    ,   module Compiler.PreAST.Type.DataType
    ,   Program(..), Subprogram(..)
    ,   RawPreAST, ADT, ABT
    ,   merge, extractFirst, extractSecond, map2
    ) where

import Compiler.PreAST.Type.Statement
import Compiler.PreAST.Raw.Type
import Compiler.PreAST.Type.Expression
import Compiler.PreAST.Type.DataType
import Compiler.PreAST.Type.Symbol
import Compiler.Syntax.Type
import Compiler.Serializable

import Data.Bifunctor
import Data.Set (Set, findMin)

--------------------------------------------------------------------------------
--  Type synonyms
--------------------------------------------------------------------------------

type RawPreAST = RawProgram
type ADT = Program (Set Declaration) Binding
type ABT = Program Declaration (Statement Value)

--------------------------------------------------------------------------------
--  Main structure
--------------------------------------------------------------------------------

data Program dec stmt = Program
    [dec]                   --  program parameters, variable and subprogram declarations
    [Subprogram dec stmt]   --  subprograms

data Subprogram dec stmt = Subprogram
    [dec]                   --  variable and subprogram declarations
    [stmt]                  --  compound statement

instance (Serializable a, Serializable b) => Serializable (Program a b) where
    serialize (Program decs subprogs) = paragraph $
            0 >>>> ["\nGlobal Variable Declarations"]
        ++  1 >>>> varDecs
        ++  0 >>>> ["\nFunction Definitions:"]
        ++  1 >>>> (map2 serializeSubprog funcDecs subprogs)
        where   serializeSubprog :: (Serializable a, Serializable b) => a -> Subprogram a b -> String
                serializeSubprog dec subprog = paragraph $
                        0 >>>> ["\n"]
                    ++  0 >>>> [dec]
                    ++  1 >>>> [subprog]

                varDecs = take varNo decs
                funcDecs = drop varNo decs

                funcNo = length subprogs
                extern = 1
                varNo = length decs - funcNo - extern

instance (Serializable a, Serializable b) => Serializable (Subprogram a b) where
    serialize (Subprogram decs stmts) = paragraph $
            0 >>>> decs
        ++  0 >>>> ["----------------"]
        ++  0 >>>> stmts

instance Bifunctor Program where
    bimap f g (Program as subprogs) = Program (map f as) (map (bimap f g) subprogs)

instance Bifunctor Subprogram where
    bimap f g (Subprogram as bs) = Subprogram (map f as) (map g bs)

--------------------------------------------------------------------------------


-- merge 2 Programs, taking the first of the first and the second of the second
merge :: Program a b -> Program c d -> Program a d
merge (Program d0 s0) (Program _ s1) = Program
    d0
    (map (uncurry mergeSubprogram) (zip s0 s1))
    where   mergeSubprogram (Subprogram d0 _) (Subprogram _ c1) = Subprogram d0 c1

extractFirst :: Program a b -> [a]
extractFirst (Program decs subprogs) = decs ++ (subprogs >>= extractSubprogramFirst)
    where   extractSubprogramFirst (Subprogram d _) = d

extractSecond :: Program a b -> [b]
extractSecond (Program _ subprogs) = subprogs >>= extractSubprogramSecond
    where   extractSubprogramSecond (Subprogram _ s) = s

map2 :: (a -> b -> c) -> [a] -> [b] -> [c]
map2 f a b = map (uncurry f) (zip a b)
