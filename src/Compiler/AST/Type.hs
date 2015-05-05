module Compiler.AST.Type
    (   module Compiler.AST.Type.Expression
    ,   module Compiler.AST.Type.Statement
    ,   module Compiler.AST.Raw.Type
    ,   module Compiler.AST.Type.Symbol
    ,   module Compiler.AST.Type.DataType
    ,   Program(..), Subprogram(..)
    ,   RawAST, AST, ABT
    ,   merge, extractFirst, extractSecond, map2
    ) where

import Compiler.AST.Type.Statement
import Compiler.AST.Raw.Type
import Compiler.AST.Type.Expression
import Compiler.AST.Type.DataType
import Compiler.AST.Type.Symbol
import Compiler.Syntax.Type
import Compiler.Serializable

import Data.Bifunctor
import Data.Set (Set, findMin)

--------------------------------------------------------------------------------
--  Main structure
--------------------------------------------------------------------------------

data Program dec stmt = Program
    [dec]                   --  program parameters, variable and subprogram declarations
    [Subprogram dec stmt]   --  subprogram
    (Subprogram dec stmt)   --  compound statement

data Subprogram dec stmt = Subprogram
    [dec]                   --  variable and subprogram declarations
    [stmt]                  --  compound statement

--------------------------------------------------------------------------------
--  Type synonyms
--------------------------------------------------------------------------------

type RawAST = RawProgram
type AST = Program (Set Declaration) Binding
type ABT = Program Declaration (Statement Value)

--------------------------------------------------------------------------------
--  Instances
--------------------------------------------------------------------------------


instance (Serializable a, Serializable b) => Serializable (Program a b) where
    serialize (Program decs subScopes stmts) = paragraph $
            0 >>>> ["Program"]
        ++  1 >>>> decs
        ++  1 >>>> subScopes
        ++  1 >>>> ["\nCOMPOUND STATEMENTS"]
        ++  1 >>>> [stmts]

instance (Serializable a, Serializable b) => Serializable (Subprogram a b) where
    serialize (Subprogram decs stmts) = paragraph $
            0 >>>> [" "]
        ++  1 >>>> decs
        ++  1 >>>> stmts

instance Bifunctor Program where
    bimap f g (Program as subprogs stmts) = Program (map f as) (map (bimap f g) subprogs) (bimap f g stmts)

instance Bifunctor Subprogram where
    bimap f g (Subprogram as bs) = Subprogram (map f as) (map g bs)

--------------------------------------------------------------------------------


-- merge 2 Programs, taking the first of the first and the second of the second
merge :: Program a b -> Program c d -> Program a d
merge (Program d0 s0 c0) (Program _ s1 c1) = Program
    d0
    (map (uncurry mergeSubprogram) (zip s0 s1))
    (mergeSubprogram c0 c1)
    where   mergeSubprogram (Subprogram d0 _) (Subprogram _ c1) = Subprogram d0 c1

extractFirst :: Program a b -> [a]
extractFirst (Program decs subprogs _) = decs ++ (subprogs >>= extractSubprogramFirst)
    where   extractSubprogramFirst (Subprogram d _) = d

extractSecond :: Program a b -> [b]
extractSecond (Program _ subprogs stmts) = subprogs ++ [stmts] >>= extractSubprogramSecond
    where   extractSubprogramSecond (Subprogram _ s) = s

map2 :: (a -> b -> c) -> [a] -> [b] -> [c]
map2 f a b = map (uncurry f) (zip a b)
