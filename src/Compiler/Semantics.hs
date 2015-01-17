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
--      1. both symbols are variables
--      2. have the same name
--      3. at the same level of scope
-- checkDeclarationDuplication :: Scope -> []
-- checkDeclarationDuplication (Scope scopeType symbols subScopes) =
