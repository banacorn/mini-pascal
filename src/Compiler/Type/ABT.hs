module Compiler.Type.ABT where

import Compiler.Type.Symbol
import qualified Compiler.Type.AST as AST

data Program = Program
    [Declaration]
    [Subprogram]
    [AST.Statement Variable]

data Subprogram = Subprogram
    [Declaration]
    [AST.Statement Variable]
