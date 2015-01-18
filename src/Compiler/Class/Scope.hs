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
    getScope p@(ProgramNode sym _ _ sub comp) = [Scope scopeType symbols scopes]
        where
            scopeType = ProgramScope (fst sym)
            symbols = getSymbol p
            scopes = getScope sub ++ getScope comp

instance HasScope SubprogramSectionNode where
    getScope (SubprogramSectionNode subprogs) = subprogs >>= getScope

instance HasScope SubprogDec where
    getScope p@(SubprogDec header _ comp) = [Scope scopeType symbols scopes]
        where
            scopeType = RegularScope $ head (getSymbol header)
            symbols = getSymbol p
            scopes = getScope comp

instance HasScope CompoundStmt where
    getScope p@(CompoundStmt stmts) = [Scope scopeType symbols scopes]
        where
            scopeType = CompoundStatementScope
            symbols = getSymbol p
            scopes = stmts >>= getScope

instance HasScope Stmt where
    getScope (VarStmt _ _) = []
    getScope (ProcStmt _) = []
    getScope (CompStmt c) = getScope c
    getScope (BranchStmt _ s t) = getScope s ++ getScope t
    getScope (LoopStmt _ s) = getScope s

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
-- Class & Instances of HasSymbol

class HasSymbol a where
    getSymbol :: a -> [Symbol]

instance HasSymbol ProgramNode where
    getSymbol (ProgramNode _ params decs subprogs _) =
        map (toSymbol (FO ProgramParamType)) params  ++
        (decs >>= getSymbol) ++
        getSymbol subprogs

instance HasSymbol DeclarationNode where
    getSymbol (DeclarationNode ids t) = map (toSymbol (getType t)) ids

instance HasSymbol SubprogramSectionNode where
    getSymbol (SubprogramSectionNode subprogs) = subprogs >>= getHeaderSymbol
        where   getHeaderSymbol (SubprogDec header _ _) = getSymbol header

instance HasSymbol SubprogDec where
    getSymbol (SubprogDec header decs _) =
        getArgumentSymbols header ++
        (decs >>= getSymbol)
        where   getArgumentSymbols (SubprogHeadFunc _ args _) = getSymbol args
                getArgumentSymbols (SubprogHeadProc _ args) = getSymbol args

instance HasSymbol SubprogHead where
    getSymbol s@(SubprogHeadFunc sym args ret) = [toSymbol (getType s) sym]
    getSymbol s@(SubprogHeadProc sym args) = [toSymbol (getType s) sym]

instance HasSymbol Arguments where
    getSymbol EmptyArguments = []
    getSymbol (Arguments xs) = xs >>= getSymbol

instance HasSymbol Param where
    getSymbol (Param ids t) = map (toSymbol (getType t)) ids

instance HasSymbol CompoundStmt where
    getSymbol (CompoundStmt stmts) = stmts >>= getSymbol

instance HasSymbol Stmt where
    getSymbol (VarStmt var expr) = getSymbol var ++ getSymbol expr
    getSymbol (ProcStmt p) = getSymbol p
    getSymbol (CompStmt _) = []
    getSymbol (BranchStmt e _ _) = getSymbol e
    getSymbol (LoopStmt e _) = getSymbol e

-- used
instance HasSymbol Variable where
    getSymbol (Variable sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)

instance HasSymbol ProcedureStmt where
    getSymbol (ProcedureStmtOnlyID sym) = [toSymbol Uninferred sym]
    getSymbol (ProcedureStmtWithExprs sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)

instance HasSymbol Expr where
    getSymbol (UnaryExpr expr) = getSymbol expr
    getSymbol (BinaryExpr a _ b) = getSymbol a ++ getSymbol b

instance HasSymbol SimpleExpr where
    getSymbol (SimpleExprTerm term) = getSymbol term
    getSymbol (SimpleExprOp a _ b) = getSymbol a ++ getSymbol b

instance HasSymbol Term where
    getSymbol (FactorTerm t) = getSymbol t
    getSymbol (OpTerm a _ b) = getSymbol a ++ getSymbol b
    getSymbol (NegTerm f) = getSymbol f

instance HasSymbol Factor where
    getSymbol (IDSBFactor sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)
    getSymbol (IDPFactor sym exprs) = [toSymbol Uninferred sym] ++ (exprs >>= getSymbol)
    getSymbol (NumFactor _) = []
    getSymbol (PFactor expr) = getSymbol expr
    getSymbol (NotFactor f) = getSymbol f
