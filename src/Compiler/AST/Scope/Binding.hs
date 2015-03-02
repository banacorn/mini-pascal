module Compiler.AST.Scope.Binding (collectBinding) where

import Compiler.Type
import Compiler.Type.AST
import Compiler.AST.Scope.Declaration
import Compiler.AST.Scope.Occurrence
import              Data.List (find)
import              Data.Set (Set)
import qualified    Data.Set as Set

collectBinding :: RawProgram -> Program () Binding
collectBinding p = collectBinding' (collectDeclaration p) (collectOccurrence p)

collectBinding' :: Program (Set Declaration) () -> Program () Occurrence -> Program () Binding
collectBinding' (Program globalDecs subDecs stmts0) (Program _ subOccs stmts1) = Program [] subScopes stmts'
    where   subScopes = map (uncurry (bindSubScope globalDecs)) (zip subDecs subOccs)
            stmts' = bindSubScope globalDecs stmts0 stmts1

findBinding :: [Set Declaration] -> Occurrence -> Binding
findBinding decs o@(Symbol name _) = case find match decs of
    Just dec -> BoundVar o dec
    Nothing  -> FreeVar o
    where   match set = symID (decSymbol (Set.findMin set)) == name

bindSubScope :: [Set Declaration] -> Subprogram (Set Declaration) () -> Subprogram () Occurrence -> Subprogram () Binding
bindSubScope globalDecs (Subprogram localDecs _) (Subprogram _ occurs) =
    Subprogram [] (map (findBinding (localDecs ++ globalDecs)) occurs)
