module Compiler.AST.Instances where

import Compiler.AST.Type
import Compiler.Serializable


--------------------------------------------------------------------------------
--  Serializable
--------------------------------------------------------------------------------

instance Serializable Variable where
    serialize (Variable label Declaration) = green label
    serialize (Variable label Local) = yellow label
    serialize (Variable label Global) = red label

instance Serializable Binding where
    serialize Declaration = "dec"
    serialize Local = "local"
    serialize Global = "global"

instance Serializable Program where
    serialize (Program decs funcs) = paragraph $
            0 >>>> ["\nGlobal Variable Declarations"]
        ++  1 >>>> [intercalate' ", " decs]
        ++  0 >>>> ["\nFunction Definitions:"]
        ++  1 >>>> funcs

instance Serializable Function where
    serialize (Function label void params decs body) = paragraph $
            0 >>>> ["\n"]
        ++  0 >>>> [returnType ++ cyan label ++ parameters]
        ++  1 >>>> [intercalate' ", " decs]
        ++  1 >>>> ["------------"]
        ++  1 >>>> body

        where   returnType = if void then "void " else "int "
                parameters = "(" ++ intercalate' ", " params ++ ")"

instance Serializable Statement where
    serialize (Assignment v e) = serialize v ++ " := " ++ serialize e
    serialize (Return e) = "return " ++ serialize e
    serialize (Invocation sym []) = serialize sym ++ "()"
    serialize (Invocation sym exprs) = serialize sym ++ "(" ++ intercalate' ", " exprs ++ ")"
    serialize (Compound stmts) = paragraph $ compound stmts
    serialize (Branch e s t) = paragraph $
            0 >>>> ["if " ++ serialize e]
        ++  1 >>>> ["then " ++ serialize s]
        ++  1 >>>> ["else " ++ serialize s]
    serialize (Loop e s) = paragraph $
            0 >>>> ["while " ++ serialize e ++ " do"]
        ++  1 >>>> [s]

instance Serializable Expression where
    serialize (UnaryExpression e) = serialize e
    serialize (BinaryExpression a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance Serializable SimpleExpression where
    serialize (TermSimpleExpression t) = serialize t
    serialize (OpSimpleExpression a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b


instance Serializable Term where
    serialize (FactorTerm f) = serialize f
    serialize (OpTerm a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
    serialize (NegTerm f) = "-" ++ serialize f

instance Serializable Factor where
    serialize (VariableFactor sym) = serialize sym
    serialize (InvocationFactor sym exprs)  = serialize sym ++ "(" ++ intercalate' ", " exprs ++ ")"
    serialize (LiteralFactor s) = serialize s
    serialize (SubFactor e) = "(" ++ serialize e ++ ")"
    serialize (NotFactor f) = "not " ++ serialize f

instance Serializable AddOp where
    serialize Plus = "+"
    serialize Minus = "-"

instance Serializable MulOp where
    serialize Mul = "*"
    serialize Div = "/"

instance Serializable RelOp where
    serialize S = "<"
    serialize L = ">"
    serialize E = "="
    serialize NE = "!="
    serialize SE = "<="
    serialize LE = ">="
