module Compiler.Class.Scope where

import Compiler.Type

--------------------------------------------------------------------------------
-- helper functions

withDepth :: Int -> [Symbol] -> SymbolTable
withDepth n xs = zip xs (repeat n)

succDepth :: SymbolTable -> SymbolTable
succDepth = map (\ (a, i) -> (a, succ i))

--------------------------------------------------------------------------------
-- Class & Instances of HasScope

class HasScope a where
    getScope :: a -> [Scope]

instance HasScope Program where
    getScope p@(Program i _ _ sub comp) = [Scope header symbols scopes]
        where
            header = Symbol Declared (FO ProgramType) i
            symbols = getSymbol p
            scopes = getScope sub ++ getScope comp

instance HasScope SubprogSection where
    getScope (SubprogSection subprogs) = subprogs >>= getScope

instance HasScope SubprogDec where
    getScope p@(SubprogDec header _ comp) = [Scope header' symbols scopes]
        where
            header' = head (getSymbol header)
            symbols = getSymbol p
            scopes = getScope comp

instance HasScope CompoundStmt where
    getScope p@(CompoundStmt stmts) = [Scope header symbols scopes]
        where
            header = Symbol Declared (FO ProgramType) "Compound Statements"
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


instance HasFOType StandardTypeN where
    getFOType IntTypeN = IntegerType
    getFOType RealTypeN = RealType
    getFOType StringTypeN = StringType

instance HasFOType TypeN where
    getFOType (StdTypeN t) = getFOType t
    getFOType (ArrayTypeN range t) = ArrayType range (getFOType t)

instance HasFOType Param where
    getFOType (Param _ t) = getFOType t

class HasType a where
    getType :: a -> Type

instance HasType StandardTypeN where
    getType = FO . getFOType

instance HasType TypeN where
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

instance HasSymbol Program where
    getSymbol (Program _ params decs subprogs _) =
        map (Symbol Declared (FO ProgramParamType)) params  ++
        (decs >>= getSymbol) ++
        getSymbol subprogs

instance HasSymbol Declaration where
    getSymbol (Declaration ids t) = map (Symbol Declared (getType t)) ids

instance HasSymbol SubprogSection where
    getSymbol (SubprogSection subprogs) = subprogs >>= getHeaderSymbol
        where   getHeaderSymbol (SubprogDec header _ _) = getSymbol header

instance HasSymbol SubprogDec where
    getSymbol (SubprogDec header decs _) =
        getArgumentSymbols header ++
        (decs >>= getSymbol)
        where   getArgumentSymbols (SubprogHeadFunc _ args _) = getSymbol args
                getArgumentSymbols (SubprogHeadProc _ args) = getSymbol args

instance HasSymbol SubprogHead where
    getSymbol p@(SubprogHeadFunc i args ret) = [Symbol Declared (getType p) i]
    getSymbol p@(SubprogHeadProc i args) = [Symbol Declared (getType p) i]

instance HasSymbol Arguments where
    getSymbol EmptyArguments = []
    getSymbol (Arguments xs) = xs >>= getSymbol

instance HasSymbol Param where
    getSymbol (Param ids t) = map (Symbol Declared (getType t)) ids

instance HasSymbol CompoundStmt where
    getSymbol (CompoundStmt stmts) = stmts >>= getSymbol

instance HasSymbol Stmt where
    getSymbol (VarStmt var expr) = getSymbol var ++ getSymbol expr
    getSymbol (ProcStmt p) = getSymbol p
    getSymbol (CompStmt _) = []
    getSymbol (BranchStmt e _ _) = getSymbol e
    getSymbol (LoopStmt e _) = getSymbol e

instance HasSymbol Variable where
    getSymbol (Variable i exprs) = [Symbol Used Uninferred i] ++ (exprs >>= getSymbol)

instance HasSymbol ProcedureStmt where
    getSymbol (ProcedureStmtOnlyID i) = [Symbol Used Uninferred i]
    getSymbol (ProcedureStmtWithExprs i exprs) = [Symbol Used Uninferred i] ++ (exprs >>= getSymbol)

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
    getSymbol (IDSBFactor i exprs) = [Symbol Used Uninferred i] ++ (exprs >>= getSymbol)
    getSymbol (IDPFactor i exprs) = [Symbol Used Uninferred i] ++ (exprs >>= getSymbol)
    getSymbol (NumFactor _) = []
    getSymbol (PFactor expr) = getSymbol expr
    getSymbol (NotFactor f) = getSymbol f
