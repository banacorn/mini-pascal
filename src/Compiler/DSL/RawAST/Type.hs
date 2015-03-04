module Compiler.DSL.RawAST.Type (HasType(..)) where

import Compiler.Type
import Compiler.Type.Type
import Compiler.Type.DSL

import Data.Monoid

--------------------------------------------------------------------------------
-- Class & Instances of HasType

instance HasType RawType where
    getType RawIntType    = BasicType IntType
    getType RawRealType   = BasicType RealType
    getType RawVoidType   = BasicType VoidType

instance HasType RawSubprogram where
    getType (FuncDec _ params ret _ _) = mconcat (map getType params) <> getType ret

instance HasType Parameter where
    getType (Parameter _ t) = getType t
