module Compiler.Class.Type (HasType(..)) where

import Compiler.Type

--------------------------------------------------------------------------------
-- Class & Instances of HasType

class HasFOType a where
    getFOType :: a -> FOType


instance HasFOType StandardTypeNode where
    getFOType IntTypeNode    = IntegerType
    getFOType RealTypeNode   = RealType
    getFOType StringTypeNode = StringType

instance HasFOType TypeNode where
    getFOType (BaseTypeNode t) = getFOType t
    getFOType (ArrayTypeNode range t) = ArrayType range (getFOType t)

instance HasFOType ParameterNode where
    getFOType (ParameterNode _ t) = getFOType t

class HasType a where
    getType :: a -> Type

instance HasType StandardTypeNode where
    getType = FO . getFOType

instance HasType TypeNode where
    getType = FO . getFOType

instance HasType SubprogDecNode where
    getType (FuncDecNode _ params ret _ _) = HO $ FunctionType  (map getFOType params) (getFOType ret)
    getType (ProcDecNode _ params     _ _) = HO $ ProcedureType (map getFOType params)
