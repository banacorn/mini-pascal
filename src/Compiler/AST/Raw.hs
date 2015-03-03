module Compiler.AST.Raw (cookAST) where

import Compiler.AST.Raw.Symbol
import Compiler.AST.Raw.Declaration

import Compiler.Type
import Compiler.Type.AST
import              Data.List (find)
import              Data.Set (Set)
import qualified    Data.Set as Set


cookAST :: RawProgram -> Program () Binding
cookAST p = collectBinding' (collectDeclaration p) (collectSymbol p)

collectBinding' :: Program (Set Declaration) () -> Program () Symbol -> Program () Binding
collectBinding' (Program globalDecs subDecs stmts0) (Program _ subOccs stmts1) = Program [] subScopes stmts'
    where   subScopes = map (uncurry (bindSubScope globalDecs)) (zip subDecs subOccs)
            stmts' = bindSubScope globalDecs stmts0 stmts1

findBinding :: [Set Declaration] -> Symbol -> Binding
findBinding decs o@(Symbol name _) = case find match decs of
    Just dec -> BoundVar o dec
    Nothing  -> FreeVar o
    where   match set = symID (decSymbol (Set.findMin set)) == name

bindSubScope :: [Set Declaration] -> Subprogram (Set Declaration) () -> Subprogram () Symbol -> Subprogram () Binding
bindSubScope globalDecs (Subprogram localDecs _) (Subprogram _ occurs) =
    Subprogram [] (map (findBinding (localDecs ++ globalDecs)) occurs)
