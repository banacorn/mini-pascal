module Compiler.Semantics where

-- Duplicate if
--      1. both symbol are variables
--      2. have the same name
--      3. at the same level of scope
-- checkDeclarationDuplication :: Scope -> []
-- checkDeclarationDuplication (Scope name symbols )
