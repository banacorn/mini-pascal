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

instance HasScope ParseTree where
    getScope (ParseTree program) = [Scope "Program" [] (getScope program)]

instance HasScope Program where
    getScope p@(Program i _ _ subs comp) = [Scope i symbols scopes]
        where
            symbols = getSymbol p
            scopes = (subs >>= getScope) ++ getScope comp

instance HasScope SubprogDec where
    getScope p@(SubprogDec header _ comp) = [Scope (getID header) symbols scopes]
        where
            symbols = getSymbol p
            scopes = getScope comp

instance HasScope CompoundStmt where
    getScope p@(CompoundStmt stmts) = [Scope "" symbols scopes]
        where
            symbols = getSymbol p
            scopes = stmts >>= getScope

instance HasScope Stmt where
    getScope (VarStmt _ _) = []
    getScope (ProcStmt _) = []
    getScope (CompStmt c) = getScope c
    getScope (BranchStmt _ s t) = getScope s ++ getScope t
    getScope (LoopStmt _ s) = getScope s

--------------------------------------------------------------------------------
-- Class & Instances of HasID

class HasID a where
    getID :: a -> String

instance HasID Program where
    getID (Program i _ _ _ _) = i

instance HasID SubprogDec where
    getID (SubprogDec header _ _) = getID header

instance HasID SubprogHead where
    getID (SubprogHeadFunc i _ _) = i
    getID (SubprogHeadProc i _) = i

--------------------------------------------------------------------------------
-- Class & Instances of HasSymbol

class HasSymbol a where
    getSymbol :: a -> [Symbol]

instance HasSymbol ParseTree where
    getSymbol _ = []

instance HasSymbol Program where
    getSymbol (Program _ params decs subs _) =
        map Declared params ++
        (decs >>= getSymbol) ++
        map (Declared . getID) subs

instance HasSymbol Declaration where
    getSymbol (Declaration ids _) = map Declared ids

instance HasSymbol SubprogDec where
    getSymbol (SubprogDec header decs _) =
        getSymbol header ++
        (decs >>= getSymbol)

instance HasSymbol SubprogHead where
    getSymbol (SubprogHeadFunc _ args _) = getSymbol args
    getSymbol (SubprogHeadProc _ args) = getSymbol args

instance HasSymbol Arguments where
    getSymbol EmptyArguments = []
    getSymbol (Arguments xs) = xs >>= getSymbol

instance HasSymbol Param where
    getSymbol (Param ids _) = map Declared ids

instance HasSymbol CompoundStmt where
    getSymbol (CompoundStmt stmts) = stmts >>= getSymbol

instance HasSymbol Stmt where
    getSymbol (VarStmt var expr) = getSymbol var ++ getSymbol expr
    getSymbol (ProcStmt p) = getSymbol p
    getSymbol (CompStmt _) = []
    getSymbol (BranchStmt e _ _) = getSymbol e
    getSymbol (LoopStmt e _) = getSymbol e

instance HasSymbol Variable where
    getSymbol (Variable i exprs) = [Used i] ++ (exprs >>= getSymbol)

instance HasSymbol ProcedureStmt where
    getSymbol (ProcedureStmtOnlyID i) = [Used i]
    getSymbol (ProcedureStmtWithExprs i exprs) = [Used i] ++ (exprs >>= getSymbol)

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
    getSymbol (IDSBFactor i exprs) = [Used i] ++ (exprs >>= getSymbol)
    getSymbol (IDPFactor i exprs) = [Used i] ++ (exprs >>= getSymbol)
    getSymbol (NumFactor _) = []
    getSymbol (PFactor expr) = getSymbol expr
    getSymbol (NotFactor f) = getSymbol f
