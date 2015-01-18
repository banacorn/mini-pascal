module Compiler.Class.Scope where

import Compiler.Type

--------------------------------------------------------------------------------
-- helper functions

withDepth :: Int -> [Symbol] -> SymbolTable
withDepth n xs = zip xs (repeat n)

succDepth :: SymbolTable -> SymbolTable
succDepth = map (\ (a, i) -> (a, succ i))

toSymbol :: Type -> (String, Position) -> Symbol
toSymbol t (i, p) = Symbol t i p

--------------------------------------------------------------------------------
-- Class & Instances of HasScope

class HasScope a where
    getScope :: a -> [Scope]

instance HasScope ProgramNode where
    getScope p@(ProgramNode sym _ _ subprogs stmts) = [Scope scopeType decs scopes]
        where
            scopeType = ProgramScope (fst sym)
            decs = getDeclaration p
            scopes = getScope subprogs ++ [] -- getScope stmts

instance HasScope SubprogramSectionNode where
    getScope (SubprogramSectionNode subprogs) = subprogs >>= getScope

instance HasScope SubprogDec where
    getScope p@(SubprogDec h@(SubprogHeadFunc sym _ _) _ stmts) = [Scope scopeType decs scopes]
        where
            scopeType = RegularScope (toSymbol (getType h) sym)
            decs = getDeclaration p
            scopes = [] --getScope stmts
    getScope p@(SubprogDec h@(SubprogHeadProc sym _) _ stmts) = [Scope scopeType decs scopes]
        where
            scopeType = RegularScope (toSymbol (getType h) sym)
            decs = getDeclaration p
            scopes = [] --getScope stmts

-- instance HasScope CompoundStmt where
--     getScope p@(CompoundStmt stmts) = [Scope scopeType symbols scopes]
--         where
--             scopeType = CompoundStatementScope
--             symbols = getSymbol p
--             scopes = stmts >>= getScope
--
-- instance HasScope Stmt where
--     getScope (VarStmt _ _) = []
--     getScope (ProcStmt _) = []
--     getScope (CompStmt c) = getScope c
--     getScope (BranchStmt _ s t) = getScope s ++ getScope t
--     getScope (LoopStmt _ s) = getScope s

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

instance HasFOType Param where
    getFOType (Param _ t) = getFOType t

class HasType a where
    getType :: a -> Type

instance HasType StandardTypeNode where
    getType = FO . getFOType

instance HasType TypeNode where
    getType = FO . getFOType


instance HasType SubprogHead where
    getType (SubprogHeadFunc _ EmptyArguments     ret) = HO $ FunctionType [] (getFOType ret)
    getType (SubprogHeadFunc _ (Arguments params) ret) = HO $ FunctionType (map getFOType params) (getFOType ret)
    getType (SubprogHeadProc _ EmptyArguments)         = HO $ ProcedureType []
    getType (SubprogHeadProc _ (Arguments params))     = HO $ ProcedureType (map getFOType params)

--------------------------------------------------------------------------------
-- Class & Instances of HasDeclaration

class HasScope a => HasDeclaration a where
    getDeclaration :: a -> [Symbol]

instance HasDeclaration ProgramNode where
    getDeclaration (ProgramNode _ params vars (SubprogramSectionNode subprogs) _) =
        (params   >>= fromParams) ++
        (vars     >>= fromVars) ++
        (subprogs >>= fromSubprogs)
        where
            fromParams n = [toSymbol (FO ProgramParamType) n]
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
            fromSubprogs (SubprogDec n@(SubprogHeadFunc sym _ ret) _ _) = [toSymbol (getType n) sym]
            fromSubprogs (SubprogDec n@(SubprogHeadProc sym _    ) _ _) = [toSymbol (getType n) sym]

instance HasDeclaration SubprogDec where
    getDeclaration (SubprogDec (SubprogHeadFunc sym EmptyArguments ret) vars stmt) =
        (vars >>= fromVars)
        where
            fromParams (Param ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
    getDeclaration (SubprogDec (SubprogHeadFunc sym (Arguments params) ret) vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (Param ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
    getDeclaration (SubprogDec (SubprogHeadProc sym EmptyArguments) vars stmt) =
        (vars >>= fromVars)
        where
            fromParams (Param ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
    getDeclaration (SubprogDec (SubprogHeadProc sym (Arguments params)) vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (Param ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids


--------------------------------------------------------------------------------
-- Class & Instances of HasSymbol
--
-- class HasSymbol a where
--     getSymbol :: a -> [Symbol]
--
-- instance HasSymbol ProgramNode where
--     getSymbol (ProgramNode _ params decs subprogs _) =
--         map (toSymbol (FO ProgramParamType)) params  ++
--         (decs >>= getSymbol) ++
--         getSymbol subprogs
--
-- instance HasSymbol VarDecNode where
--     getSymbol (VarDecNode ids t) = map (toSymbol (getType t)) ids
--
-- instance HasSymbol SubprogramSectionNode where
--     getSymbol (SubprogramSectionNode subprogs) = subprogs >>= getHeaderSymbol
--         where   getHeaderSymbol (SubprogDec header _ _) = getSymbol header
--
-- instance HasSymbol SubprogDec where
--     getSymbol (SubprogDec header decs _) =
--         getArgumentSymbols header ++
--         (decs >>= getSymbol)
--         where   getArgumentSymbols (SubprogHeadFunc _ args _) = getSymbol args
--                 getArgumentSymbols (SubprogHeadProc _ args) = getSymbol args
--
-- instance HasSymbol SubprogHead where
--     getSymbol s@(SubprogHeadFunc sym args ret) = [toSymbol (getType s) sym]
--     getSymbol s@(SubprogHeadProc sym args) = [toSymbol (getType s) sym]
--
-- instance HasSymbol Arguments where
--     getSymbol EmptyArguments = []
--     getSymbol (Arguments xs) = xs >>= getSymbol
--
-- instance HasSymbol Param where
--     getSymbol (Param ids t) = map (toSymbol (getType t)) ids
--
-- instance HasSymbol CompoundStmt where
--     getSymbol (CompoundStmt stmts) = stmts >>= getSymbol
--
-- instance HasSymbol Stmt where
--     getSymbol (VarStmt var expr) = getSymbol var ++ getSymbol expr
--     getSymbol (ProcStmt p) = getSymbol p
--     getSymbol (CompStmt _) = []
--     getSymbol (BranchStmt e _ _) = getSymbol e
--     getSymbol (LoopStmt e _) = getSymbol e
--
-- -- used
-- instance HasSymbol Variable where
--     getSymbol (Variable sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)
--
-- instance HasSymbol ProcedureStmt where
--     getSymbol (ProcedureStmtOnlyID sym) = [toSymbol Uninferred sym]
--     getSymbol (ProcedureStmtWithExprs sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)
--
-- instance HasSymbol Expr where
--     getSymbol (UnaryExpr expr) = getSymbol expr
--     getSymbol (BinaryExpr a _ b) = getSymbol a ++ getSymbol b
--
-- instance HasSymbol SimpleExpr where
--     getSymbol (SimpleExprTerm term) = getSymbol term
--     getSymbol (SimpleExprOp a _ b) = getSymbol a ++ getSymbol b
--
-- instance HasSymbol Term where
--     getSymbol (FactorTerm t) = getSymbol t
--     getSymbol (OpTerm a _ b) = getSymbol a ++ getSymbol b
--     getSymbol (NegTerm f) = getSymbol f
--
-- instance HasSymbol Factor where
--     getSymbol (IDSBFactor sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)
--     getSymbol (IDPFactor sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)
--     getSymbol (NumFactor _) = []
--     getSymbol (PFactor expr) = getSymbol expr
--     getSymbol (NotFactor f) = getSymbol f
