module Compiler.DSL.RawAST.Type (HasType(..)) where

import Compiler.Type
import Compiler.Type.DSL

import Data.Monoid

--------------------------------------------------------------------------------
-- Class & Instances of HasType

class HasType a where
    getType :: a -> Type

instance HasType BasicType where
    getType RawIntType    = Type [IntegerType]
    getType RawRealType   = Type [RealType]
    getType RawStringType = Type [StringType]

instance HasType RawType where
    getType (Basic t) = getType t
    getType (Array range t) = let Type [t'] = getType t in Type [ArrayType range t']

instance HasType RawSubprogram where
    getType (FuncDec _ params ret _ _) = mconcat (map getType params) <> getType ret
    getType (ProcDec _ params     _ _) = mconcat (map getType params) <> Type [UnitType]

instance HasType Parameter where
    getType (Parameter _ t) = getType t
