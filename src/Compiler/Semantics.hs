module Compiler.Semantics where

import Compiler.Type

--------------------------------------------------------------------------------
-- A Symbol is either Declared or Used, here we keep the declared symbols only
extractDeclaration :: Scope -> Scope
extractDeclaration (Scope scopeType symbols subScopes) =
    Scope scopeType (filter isDeclaration symbols) (map extractDeclaration subScopes)
    where   isDeclaration :: Symbol -> Bool
            isDeclaration (Symbol Declared _ _ _) = True
            isDeclaration _                     = False

-- Duplicate if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
--      3. at the same level of scope
checkDeclarationDuplication :: Scope -> [[Symbol]]
checkDeclarationDuplication (Scope scopeType symbols subScopes) =
    pickDuplicated (equivalenceClassPartition symbols)
    ++ (subScopes >>= checkDeclarationDuplication)
    where   pickDuplicated = filter ((>1) . length)

-- form a partition with Eq
equivalenceClassPartition :: Eq a => [a] -> [[a]]
equivalenceClassPartition [] = []
equivalenceClassPartition (x:xs) = testAgainst x (equivalenceClassPartition xs)
    where   testAgainst x [] = [[x]]
            testAgainst x (c:cs) | x == head c = (x:c):cs
                                 | otherwise   = c : testAgainst x cs
