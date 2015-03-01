module Compiler.AST.Type (HasType(..)) where

import Compiler.Type
import Compiler.Type.AST

import Data.Monoid

--------------------------------------------------------------------------------
-- Class & Instances of HasType

class HasType a where
    getType :: a -> Type

instance HasType StandardTypeNode where
    getType IntTypeNode    = Type [IntegerType]
    getType RealTypeNode   = Type [RealType]
    getType StringTypeNode = Type [StringType]

instance HasType TypeNode where
    getType (BaseTypeNode t) = getType t
    getType (ArrayTypeNode range t) = let Type [t'] = getType t in Type [ArrayType range t']

instance HasType SubprogDecNode where
    getType (FuncDecNode _ params ret _ _) = mconcat (map getType params) <> getType ret
    getType (ProcDecNode _ params     _ _) = mconcat (map getType params) <> Type [UnitType]

instance HasType ParameterNode where
    getType (ParameterNode _ t) = getType t
