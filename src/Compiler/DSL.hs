module Compiler.DSL (toAST, toABT) where

import Compiler.DSL.Type
import Compiler.DSL.RawAST
import Compiler.Syntax.Type

import              Data.List (find)
import              Data.Set (Set)
import qualified    Data.Set as Set
import              Data.Bifunctor

--------------------------------------------------------------------------------
-- AST
--------------------------------------------------------------------------------

toAST :: RawAST -> AST
toAST p = merge declarations bindings
    where   declarations = collectDeclaration p
            symbols = collectSymbol p
            bindings = collectBinding declarations symbols

collectBinding :: Program (Set Declaration) () -> Program () Symbol -> Program () Binding
collectBinding (Program globalDecs subDecs stmts0) (Program _ subOccs stmts1) = Program
    []
    (map (uncurry (bindSubprogram globalDecs)) (zip subDecs subOccs))
    (bindSubprogram globalDecs stmts0 stmts1)

findBinding :: [Set Declaration] -> Symbol -> Binding
findBinding decs o@(Symbol name _) = (o, find match decs)
    where   match set = symID (decSymbol (Set.findMin set)) == name

bindSubprogram :: [Set Declaration] -> Subprogram (Set Declaration) () -> Subprogram () Symbol -> Subprogram () Binding
bindSubprogram globalDecs (Subprogram localDecs _) (Subprogram _ occurs) =
    Subprogram [] (map (findBinding (localDecs ++ globalDecs)) occurs)

--------------------------------------------------------------------------------
-- ABT
--------------------------------------------------------------------------------

toABT :: RawAST -> AST -> ABT
toABT raw ast = restoreStatement raw (bimap Set.findMin toValue ast)
