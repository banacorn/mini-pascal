module Compiler.AST.Type (HasType(..)) where

import Compiler.Type
import qualified Compiler.Type.AST as AST

import Data.Monoid

--------------------------------------------------------------------------------
-- Class & Instances of HasType

class HasType a where
    getType :: a -> Type

instance HasType AST.BasicType where
    getType AST.IntType    = Type [IntegerType]
    getType AST.RealType   = Type [RealType]
    getType AST.StringType = Type [StringType]

instance HasType AST.Type where
    getType (AST.Basic t) = getType t
    getType (AST.Array range t) = let Type [t'] = getType t in Type [ArrayType range t']

instance HasType AST.RawSubprogram where
    getType (AST.FuncDec _ params ret _ _) = mconcat (map getType params) <> getType ret
    getType (AST.ProcDec _ params     _ _) = mconcat (map getType params) <> Type [UnitType]

instance HasType AST.Parameter where
    getType (AST.Parameter _ t) = getType t
