module Compiler.Class.Scope where

import Compiler.Type

--------------------------------------------------------------------------------
-- helper functions

toSymbol :: Type -> (String, Position) -> Symbol
toSymbol t (i, p) = Symbol t i p

--------------------------------------------------------------------------------
-- Class & Instances of HasScope

class HasScope a where
    getScope :: a -> [b] -> Scope b

instance HasScope ProgramNode where
    getScope p@(ProgramNode sym _ _ subprogs stmts) = AbstractScope scopeType scopes
        where
            scopeType = ProgramScope (fst sym)
            scopes = map getScope subprogs -- ++ map getScope stmts

instance HasScope SubprogDecNode where
    getScope p@(FuncDecNode sym _ _ _ stmts) = AbstractScope scopeType scopes
        where
            scopeType = RegularScope (toSymbol (getType p) sym)
            scopes = [] --getScope stmts
    getScope p@(ProcDecNode sym _ _ stmts) = AbstractScope scopeType scopes
        where
            scopeType = RegularScope (toSymbol (getType p) sym)
            -- decs = getDeclaration p
            scopes = [] --getScope stmts


--------------------------------------------------------------------------------
-- Class & Instances of HasType

class HasFOType a where
    getFOType :: a -> FOType


instance HasFOType StandardTypeNode where
    getFOType IntTypeNode    = IntegerType
    getFOType RealTypeNode   = RealType
    getFOType StringTypeNode = StringType

instance HasFOType TypeNode where
    getFOType (BaseTypeNode t) = getFOType t
    getFOType (ArrayTypeNode range t) = ArrayType range (getFOType t)

instance HasFOType ParameterNode where
    getFOType (ParameterNode _ t) = getFOType t

class HasType a where
    getType :: a -> Type

instance HasType StandardTypeNode where
    getType = FO . getFOType

instance HasType TypeNode where
    getType = FO . getFOType

instance HasType SubprogDecNode where
    getType (FuncDecNode _ params ret _ _) = HO $ FunctionType  (map getFOType params) (getFOType ret)
    getType (ProcDecNode _ params     _ _) = HO $ ProcedureType (map getFOType params)

--------------------------------------------------------------------------------
-- Class & Instances of HasDeclaration

class HasScope a => HasDeclaration a where
    getDeclaration :: a -> [Symbol]

instance HasDeclaration ProgramNode where
    getDeclaration (ProgramNode _ params vars subprogs _) =
        (params   >>= fromParams) ++
        (vars     >>= fromVars) ++
        (subprogs >>= fromSubprogs)
        where
            fromParams n = [toSymbol (FO ProgramParamType) n]
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
            fromSubprogs n@(FuncDecNode sym _ ret _ _) = [toSymbol (getType n) sym]
            fromSubprogs n@(ProcDecNode sym _     _ _) = [toSymbol (getType n) sym]

instance HasDeclaration SubprogDecNode where
    getDeclaration (FuncDecNode sym params ret vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (ParameterNode ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
    getDeclaration (ProcDecNode sym params vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (ParameterNode ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
