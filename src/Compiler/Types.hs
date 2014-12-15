module Compiler.Types where

import Control.Monad.Except
import Data.List (intercalate)

import Compiler.Serialize
import Compiler.Scope

-- Pipeline
type Pipeline = ExceptT PipelineError IO

data Position = Position {
        posOffset :: Int
    ,   posLine :: Int
    ,   posColumn :: Int
    }

instance Show Position where
    show (Position offset line column) =
        "line " ++ show line
        ++ " column " ++ show column

data PipelineError  = FileError String
                    | LexError Position String
                    | ParseError Position String
                    | SemanticError String

instance Show PipelineError where
    show (FileError e) = e
    show (LexError pos msg) = "Lex Error: \n"
        ++ show pos ++ "\n"
        ++ show msg
    show (ParseError pos msg) = "Lex Error: \n"
        ++ show pos ++ "\n"
        ++ msg
    show (SemanticError e) = e

-- AST
data ParseTree = ParseTree Program
    deriving (Eq, Show)

instance Serializable ParseTree where
    serialize (ParseTree program) = serialize program

instance HasSymbol ParseTree where
    getSymbol _ = []

instance HasScope ParseTree where
    getScope (ParseTree program) = [Scope "Program" [] (getScope program)]

data Program = Program ID [ID] [Declaration] [SubprogDec] CompoundStmt
    deriving (Eq, Show)

instance Serializable Program where
    serialize (Program i is decs subprogdecs comp) =
        "\n" ++
        header ++ "\n" ++
        indent decs ++ "\n" ++
        indent subprogdecs ++
        indentBlock (serialize comp) ++
        ".\n"
        where
            header = "program " ++ i ++ "(" ++ serializeIDs is ++ ") ;" ++ "\n"
            serializeIDs [] = error "serialize empty ids"
            serializeIDs [x] = x
            serializeIDs (x:xs) = x ++ ", " ++ serializeIDs xs

instance HasID Program where
    getID (Program i _ _ _ _) = i

instance HasSymbol Program where
    getSymbol (Program _ is decs subs _) =
        is ++
        (decs >>= getSymbol) ++
        (map getID subs)

instance HasScope Program where
    getScope p@(Program i _ _ subs comp) = [Scope i symbols scopes]
        where
            symbols = getSymbol p
            scopes = (subs >>= getScope) ++ getScope comp

type ID = String
data Declaration = Declaration [ID] Type
    deriving (Eq, Show)

instance Serializable Declaration where
    serialize (Declaration [] _) = []
    serialize (Declaration ids t) =
        "var " ++ serializeIDs ids ++ " : " ++ serialize t ++ ";"
        where
            serializeIDs = intercalate ", "

instance HasSymbol Declaration where
    getSymbol (Declaration ids _) = ids

type Number = String
data Type   = StdType StandardType
            | ArrayType (Number, Number) Type
            deriving (Eq, Show)
data StandardType = IntType | RealType | StringType deriving (Eq, Show)

instance Serializable Type where
    serialize (StdType t) = serialize t
    serialize (ArrayType (a, b) t) = "array [ " ++ a ++ " .. " ++ b ++ " ] of " ++ serialize t

instance Serializable StandardType where
    serialize IntType = "int"
    serialize RealType = "real"
    serialize StringType = "string"

data SubprogDec = SubprogDec SubprogHead [Declaration] CompoundStmt deriving (Eq, Show)

instance Serializable SubprogDec where
    serialize (SubprogDec header decs comp) =
        serialize header ++ "\n" ++
        indent decs ++
        indentBlock (serialize comp)

instance HasID SubprogDec where
    getID (SubprogDec header _ _) = getID header

instance HasSymbol SubprogDec where
    getSymbol (SubprogDec header decs _) =
        getSymbol header ++
        (decs >>= getSymbol)

instance HasScope SubprogDec where
    getScope p@(SubprogDec header _ comp) = [Scope (getID header) symbols scopes]
        where
            symbols = getSymbol p
            scopes = getScope comp

data SubprogHead    = SubprogHeadFunc ID Arguments StandardType
                    | SubprogHeadProc ID Arguments
                    deriving (Eq, Show)


instance Serializable SubprogHead where
    serialize (SubprogHeadFunc i args typ) =
        "function " ++ i ++ serialize args ++ " : " ++ serialize typ ++ ";"
    serialize (SubprogHeadProc i args) =
        "procedure " ++ i ++ serialize args ++ ";"

instance HasID SubprogHead where
    getID (SubprogHeadFunc i _ _) = i
    getID (SubprogHeadProc i _) = i

instance HasSymbol SubprogHead where
    getSymbol (SubprogHeadFunc _ args _) = getSymbol args
    getSymbol (SubprogHeadProc _ args) = getSymbol args

data Arguments  = EmptyArguments
                | Arguments [Param]
                deriving (Eq, Show)

instance Serializable Arguments where
    serialize EmptyArguments = ""
    serialize (Arguments xs) = "(" ++ serializeArgs ++ ")"
        where
            serializeArgs = intercalate "; " (map serialize xs)

instance HasSymbol Arguments where
    getSymbol EmptyArguments = []
    getSymbol (Arguments xs) = xs >>= getSymbol

data Param = Param [ID] Type
    deriving (Eq, Show)

instance Serializable Param where
    serialize (Param ids t) = serializeIDs ++ ": " ++ serialize t
        where   serializeIDs = intercalate ", " ids

instance HasSymbol Param where
    getSymbol (Param ids _) = ids

data CompoundStmt = CompoundStmt [Stmt]
    deriving (Eq, Show)

instance Serializable CompoundStmt where
    serialize (CompoundStmt stmts) =
        "begin" ++ "\n" ++
        indentWith (suffix ";\n") stmts ++
        "end"

instance HasSymbol CompoundStmt where
    getSymbol (CompoundStmt stmts) = stmts >>= getSymbol

instance HasScope CompoundStmt where
    getScope p@(CompoundStmt stmts) = [Scope "" symbols scopes]
        where
            symbols = getSymbol p
            scopes = stmts >>= getScope

data Stmt   = VarStmt Variable Expr
            | ProcStmt ProcedureStmt
            | CompStmt CompoundStmt
            | BranchStmt Expr Stmt Stmt
            | LoopStmt Expr Stmt
            deriving (Eq, Show)


instance Serializable Stmt where
    serialize (VarStmt v e) = serialize v ++ " := " ++ serialize e
    serialize (ProcStmt p) = serialize p
    serialize (CompStmt c) = serialize c
    serialize (BranchStmt e s t) =
        "if " ++ serialize e ++ "\n" ++
        "    then " ++ serialize s ++ "\n" ++
        "    else " ++ serialize t
    serialize (LoopStmt e s) = "while " ++ serialize e ++ " do " ++ serialize s

instance HasSymbol Stmt where
    getSymbol (VarStmt var expr) = getSymbol var ++ getSymbol expr
    getSymbol (ProcStmt p) = getSymbol p
    getSymbol (CompStmt _) = []
    getSymbol (BranchStmt e _ _) = getSymbol e
    getSymbol (LoopStmt e _) = getSymbol e

instance HasScope Stmt where
    getScope (VarStmt _ _) = []
    getScope (ProcStmt _) = []
    getScope (CompStmt c) = getScope c
    getScope (BranchStmt _ s t) = getScope s ++ getScope t
    getScope (LoopStmt _ s) = getScope s

data Variable = Variable ID [Expr] -- e.g. a[1+2][3*4]
    deriving (Eq, Show)

instance Serializable Variable where
    serialize (Variable i es) = i ++ concat (map showSBExpr es)
        where   showSBExpr e = "[" ++ serialize e ++ "]"

instance HasSymbol Variable where
    getSymbol (Variable i exprs) = [i] ++ (exprs >>= getSymbol)

-- procedure invocation
data ProcedureStmt  = ProcedureStmtOnlyID ID
                    | ProcedureStmtWithExprs ID [Expr]
                    deriving (Eq, Show)

instance Serializable ProcedureStmt where
    serialize (ProcedureStmtOnlyID i) = i
    serialize (ProcedureStmtWithExprs i es) = i ++ "(" ++ serializeExpr ++ ")"
        where   serializeExpr = intercalate ", " (map serialize es)

instance HasSymbol ProcedureStmt where
    getSymbol (ProcedureStmtOnlyID i) = [i]
    getSymbol (ProcedureStmtWithExprs i exprs) = [i] ++ (exprs >>= getSymbol)

data Expr   = UnaryExpr SimpleExpr
            | BinaryExpr SimpleExpr Relop SimpleExpr
            deriving (Eq, Show)

instance Serializable Expr where
    serialize (UnaryExpr e) = serialize e
    serialize (BinaryExpr a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance HasSymbol Expr where
    getSymbol (UnaryExpr expr) = getSymbol expr
    getSymbol (BinaryExpr a _ b) = getSymbol a ++ getSymbol b

data SimpleExpr = SimpleExprTerm Term
                | SimpleExprOp SimpleExpr AddOp Term
                deriving (Eq, Show)

instance Serializable SimpleExpr where
    serialize (SimpleExprTerm t) = serialize t
    serialize (SimpleExprOp a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance HasSymbol SimpleExpr where
    getSymbol (SimpleExprTerm term) = getSymbol term
    getSymbol (SimpleExprOp a _ b) = getSymbol a ++ getSymbol b

data Term   = FactorTerm Factor
            | OpTerm Term MulOp Factor
            | NegTerm Factor
            deriving (Eq, Show)

instance Serializable Term where
    serialize (FactorTerm f) = serialize f
    serialize (OpTerm a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
    serialize (NegTerm f) = "-" ++ serialize f

instance HasSymbol Term where
    getSymbol (FactorTerm t) = getSymbol t
    getSymbol (OpTerm a _ b) = getSymbol a ++ getSymbol b
    getSymbol (NegTerm f) = getSymbol f

data Factor = IDSBFactor ID [Expr]  -- id[]
            | IDPFactor ID [Expr]   -- id()
            | NumFactor String
            | PFactor Expr
            | NotFactor Factor
            deriving (Eq, Show)

instance Serializable Factor where
    serialize (IDSBFactor i es) = i ++ concat (map serialize es)
        where   serializeSBExpr a = "[" ++ serialize a ++ "]"
    serialize (IDPFactor i es)  = i ++ "(" ++ serializeExpr ++ ")"
        where   serializeExpr = intercalate ", " (map serialize es)
    serialize (NumFactor s) = s
    serialize (PFactor e) = serialize e
    serialize (NotFactor f) = "not " ++ serialize f

instance HasSymbol Factor where
    getSymbol (IDSBFactor i exprs) = [i] ++ (exprs >>= getSymbol)
    getSymbol (IDPFactor i exprs) = [i] ++ (exprs >>= getSymbol)
    getSymbol (NumFactor _) = []
    getSymbol (PFactor expr) = getSymbol expr
    getSymbol (NotFactor f) = getSymbol f

data AddOp = Plus | Minus deriving (Eq, Show)
data MulOp = Mul | Div deriving (Eq, Show)
data Relop = S | L | E | NE | SE | LE deriving (Eq, Show)

instance Serializable AddOp where
    serialize Plus = "+"
    serialize Minus = "-"

instance Serializable MulOp where
    serialize Mul = "*"
    serialize Div = "/"

instance Serializable Relop where
    serialize S = "<"
    serialize L = ">"
    serialize E = "="
    serialize NE = "!="
    serialize SE = "<="
    serialize LE = ">="
