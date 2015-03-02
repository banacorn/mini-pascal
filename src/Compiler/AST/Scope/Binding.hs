module Compiler.AST.Scope.Binding (collectBinding) where

import Compiler.Type
import Compiler.Type.AST
import Compiler.AST.Scope.Declaration
import Compiler.AST.Scope.Occurrence
import              Data.List (find)
import              Data.Set (Set)
import qualified    Data.Set as Set

collectBinding :: Program -> Scope () Binding
collectBinding p = collectBinding' (collectDeclaration p) (collectOccurrence p)

collectBinding' :: Scope (Set Declaration) () -> Scope () Occurrence -> Scope () Binding
collectBinding' (Scope globalDecs subDecs stmts0) (Scope _ subOccs stmts1) = Scope [] subScopes stmts'
    where   subScopes = map (uncurry (bindSubScope globalDecs)) (zip subDecs subOccs)
            stmts' = bindSubScope globalDecs stmts0 stmts1

findBinding :: [Set Declaration] -> Occurrence -> Binding
findBinding decs o@(Symbol name _) = case find match decs of
    Just dec -> BoundVar o dec
    Nothing  -> FreeVar o
    where   match set = symID (decSymbol (Set.findMin set)) == name

bindSubScope :: [Set Declaration] -> SubScope (Set Declaration) () -> SubScope () Occurrence -> SubScope () Binding
bindSubScope globalDecs (SubScope localDecs _) (SubScope _ occurs) =
    SubScope [] (map (findBinding (localDecs ++ globalDecs)) occurs)
