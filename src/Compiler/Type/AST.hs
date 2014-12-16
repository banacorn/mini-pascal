module Compiler.Type.AST where

-- import Compiler.Class.Serializable
-- import Compiler.Class.Scope

-- AST
data ParseTree = ParseTree Program
    deriving (Eq, Show)

-- instance HasSymbol ParseTree where
--     getSymbol _ = []
--
-- instance HasScope ParseTree where
--     getScope (ParseTree program) = [Scope "Program" [] (getScope program)]

data Program = Program ID [ID] [Declaration] [SubprogDec] CompoundStmt
    deriving (Eq, Show)

-- instance HasID Program where
--     getID (Program i _ _ _ _) = i
--
-- instance HasSymbol Program where
--     getSymbol (Program _ is decs subs _) =
--         is ++
--         (decs >>= getSymbol) ++
--         (map getID subs)
--
-- instance HasScope Program where
--     getScope p@(Program i _ _ subs comp) = [Scope i symbols scopes]
--         where
--             symbols = getSymbol p
--             scopes = (subs >>= getScope) ++ getScope comp

type ID = String
data Declaration = Declaration [ID] Type
    deriving (Eq, Show)

-- instance HasSymbol Declaration where
--     getSymbol (Declaration ids _) = ids

type Number = String
data Type   = StdType StandardType
            | ArrayType (Number, Number) Type
            deriving (Eq, Show)
data StandardType = IntType | RealType | StringType deriving (Eq, Show)

-- instance Serializable StandardType where
--     serialize IntType = "int"
--     serialize RealType = "real"
--     serialize StringType = "string"

data SubprogDec = SubprogDec SubprogHead [Declaration] CompoundStmt deriving (Eq, Show)

-- instance HasID SubprogDec where
--     getID (SubprogDec header _ _) = getID header
--
-- instance HasSymbol SubprogDec where
--     getSymbol (SubprogDec header decs _) =
--         getSymbol header ++
--         (decs >>= getSymbol)
--
-- instance HasScope SubprogDec where
--     getScope p@(SubprogDec header _ comp) = [Scope (getID header) symbols scopes]
--         where
--             symbols = getSymbol p
--             scopes = getScope comp

data SubprogHead    = SubprogHeadFunc ID Arguments StandardType
                    | SubprogHeadProc ID Arguments
                    deriving (Eq, Show)


-- instance HasID SubprogHead where
--     getID (SubprogHeadFunc i _ _) = i
--     getID (SubprogHeadProc i _) = i
--
-- instance HasSymbol SubprogHead where
--     getSymbol (SubprogHeadFunc _ args _) = getSymbol args
--     getSymbol (SubprogHeadProc _ args) = getSymbol args

data Arguments  = EmptyArguments
                | Arguments [Param]
                deriving (Eq, Show)

-- instance HasSymbol Arguments where
--     getSymbol EmptyArguments = []
--     getSymbol (Arguments xs) = xs >>= getSymbol

data Param = Param [ID] Type
    deriving (Eq, Show)

-- instance HasSymbol Param where
--     getSymbol (Param ids _) = ids

data CompoundStmt = CompoundStmt [Stmt]
    deriving (Eq, Show)

-- instance HasSymbol CompoundStmt where
--     getSymbol (CompoundStmt stmts) = stmts >>= getSymbol
--
-- instance HasScope CompoundStmt where
--     getScope p@(CompoundStmt stmts) = [Scope "" symbols scopes]
--         where
--             symbols = getSymbol p
--             scopes = stmts >>= getScope

data Stmt   = VarStmt Variable Expr
            | ProcStmt ProcedureStmt
            | CompStmt CompoundStmt
            | BranchStmt Expr Stmt Stmt
            | LoopStmt Expr Stmt
            deriving (Eq, Show)


-- instance HasSymbol Stmt where
--     getSymbol (VarStmt var expr) = getSymbol var ++ getSymbol expr
--     getSymbol (ProcStmt p) = getSymbol p
--     getSymbol (CompStmt _) = []
--     getSymbol (BranchStmt e _ _) = getSymbol e
--     getSymbol (LoopStmt e _) = getSymbol e
--
-- instance HasScope Stmt where
--     getScope (VarStmt _ _) = []
--     getScope (ProcStmt _) = []
--     getScope (CompStmt c) = getScope c
--     getScope (BranchStmt _ s t) = getScope s ++ getScope t
--     getScope (LoopStmt _ s) = getScope s

data Variable = Variable ID [Expr] -- e.g. a[1+2][3*4]
    deriving (Eq, Show)

-- instance HasSymbol Variable where
--     getSymbol (Variable i exprs) = [i] ++ (exprs >>= getSymbol)

-- procedure invocation
data ProcedureStmt  = ProcedureStmtOnlyID ID
                    | ProcedureStmtWithExprs ID [Expr]
                    deriving (Eq, Show)

-- instance HasSymbol ProcedureStmt where
--     getSymbol (ProcedureStmtOnlyID i) = [i]
--     getSymbol (ProcedureStmtWithExprs i exprs) = [i] ++ (exprs >>= getSymbol)

data Expr   = UnaryExpr SimpleExpr
            | BinaryExpr SimpleExpr Relop SimpleExpr
            deriving (Eq, Show)

-- instance HasSymbol Expr where
--     getSymbol (UnaryExpr expr) = getSymbol expr
--     getSymbol (BinaryExpr a _ b) = getSymbol a ++ getSymbol b

data SimpleExpr = SimpleExprTerm Term
                | SimpleExprOp SimpleExpr AddOp Term
                deriving (Eq, Show)

-- instance HasSymbol SimpleExpr where
--     getSymbol (SimpleExprTerm term) = getSymbol term
--     getSymbol (SimpleExprOp a _ b) = getSymbol a ++ getSymbol b

data Term   = FactorTerm Factor
            | OpTerm Term MulOp Factor
            | NegTerm Factor
            deriving (Eq, Show)

-- instance HasSymbol Term where
--     getSymbol (FactorTerm t) = getSymbol t
--     getSymbol (OpTerm a _ b) = getSymbol a ++ getSymbol b
--     getSymbol (NegTerm f) = getSymbol f

data Factor = IDSBFactor ID [Expr]  -- id[]
            | IDPFactor ID [Expr]   -- id()
            | NumFactor String
            | PFactor Expr
            | NotFactor Factor
            deriving (Eq, Show)

-- instance HasSymbol Factor where
--     getSymbol (IDSBFactor i exprs) = [i] ++ (exprs >>= getSymbol)
--     getSymbol (IDPFactor i exprs) = [i] ++ (exprs >>= getSymbol)
--     getSymbol (NumFactor _) = []
--     getSymbol (PFactor expr) = getSymbol expr
--     getSymbol (NotFactor f) = getSymbol f

data AddOp = Plus | Minus deriving (Eq, Show)
data MulOp = Mul | Div deriving (Eq, Show)
data Relop = S | L | E | NE | SE | LE deriving (Eq, Show)
