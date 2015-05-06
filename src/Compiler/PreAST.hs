module Compiler.PreAST (toADT, toABT) where

import Compiler.PreAST.Type
import Compiler.PreAST.Raw
import Compiler.Syntax.Type

import              Data.List (find)
import              Data.Set (Set)
import qualified    Data.Set as Set
import              Data.Bifunctor

--------------------------------------------------------------------------------
-- ADT
--------------------------------------------------------------------------------

toADT :: RawPreAST -> ADT
toADT p = merge declarations bindings
    where   declarations = collectDeclaration p
            symbols = collectSymbol p
            bindings = collectBinding declarations symbols

collectBinding :: Program (Set Declaration) () -> Program () Symbol -> Program () Binding
collectBinding (Program globalDecs subDecs) (Program _ subOccs) = Program
    []
    (map (uncurry (bindSubprogram globalDecs)) (zip subDecs subOccs))

findBinding :: [Set Declaration] -> Symbol -> Binding
findBinding decs o@(Symbol name _) = (o, find match decs)
    where   match set = symID (decSymbol (Set.findMin set)) == name

bindSubprogram :: [Set Declaration] -> Subprogram (Set Declaration) () -> Subprogram () Symbol -> Subprogram () Binding
bindSubprogram globalDecs (Subprogram localDecs _) (Subprogram _ occurs) =
    Subprogram [] (map (findBinding (localDecs ++ globalDecs)) occurs)

--------------------------------------------------------------------------------
-- ABT
--------------------------------------------------------------------------------

toABT :: RawPreAST -> ADT -> ABT
toABT raw adt = restoreStatement raw (bimap Set.findMin toValue adt)
--
-- --------------------------------------------------------------------------------
-- -- Final
-- --------------------------------------------------------------------------------
--
-- data DataType = IntType | RealType
-- data VarDec = VarDec Type String
--
-- data PreAST = Program VarDec Statement
