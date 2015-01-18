module Compiler.Semantics where

import Compiler.Type

import Control.Monad.Except

--------------------------------------------------------------------------------
-- A Symbol is either Declared or Used, here we keep the declared symbols only
extractDeclaration :: Scope -> Scope
extractDeclaration (Scope scopeType symbols subScopes) =
    Scope scopeType (filter isDeclaration symbols) (map extractDeclaration subScopes)
    where   isDeclaration :: Symbol -> Bool
            isDeclaration (Symbol Declared _ _ _) = True
            isDeclaration _                     = False

checkDeclarationDuplication :: Scope -> Pipeline ()
checkDeclarationDuplication scope = case declarationDuplications scope of
    [] -> return ()
    xs -> do
        
        throwError SemanticsError

-- Duplicate if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
--      3. at the same level of scope
declarationDuplications :: Scope -> [[Symbol]]
declarationDuplications (Scope scopeType symbols subScopes) =
    pickDuplicated (equivalenceClassPartition symbols)
    ++ (subScopes >>= declarationDuplications)
    where   pickDuplicated = filter ((>1) . length)

-- form a partition with the equiped equivalence relation
equivalenceClassPartition :: Eq a => [a] -> [[a]]
equivalenceClassPartition = foldl addToPartition []
    where   addToPartition [] x     = [[x]]
            addToPartition (c:cs) x | x == head c = (x:c):cs
                                    | otherwise   = c : addToPartition cs x
