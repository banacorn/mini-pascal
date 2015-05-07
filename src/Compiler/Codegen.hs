{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler.Codegen where

import Control.Monad

import Compiler.Codegen.State
import Compiler.Codegen.Instruction
import qualified Compiler.AST.Type as AST


import LLVM.General.AST.Type hiding (void)
import LLVM.General.AST
import LLVM.General.AST.Global as Glb
import qualified LLVM.General.AST.Constant as C
import qualified LLVM.General.AST.Linkage as L
import qualified LLVM.General.AST.IntegerPredicate as IP


--------------------------------------------------------------------------------
--  Module & Global Definitions
--------------------------------------------------------------------------------

genGlobalVariable :: AST.Variable -> Definition
genGlobalVariable (AST.Variable label _) = GlobalDefinition $ globalVariableDefaults {
        Glb.name = Name label
    ,   Glb.type' = i32
    ,   Glb.linkage = L.Common
    ,   Glb.initializer = Just (C.Int 32 0)
    }

genFunction :: AST.Function -> Definition
genFunction (AST.Function label ret params decs body) = GlobalDefinition $ functionDefaults {
        name        = Name label
    ,   parameters  = ([ Parameter i32 (Name name) [] | AST.Variable name _ <- params ], False)
    ,   returnType  = if ret then VoidType else i32
    ,   basicBlocks = createBlocks . execCodegen $ do
            entry <- addBlock "entry"
            setBlock entry
            sequence (map genParameter params)
            sequence (map genLocalVariable decs)
            sequence (map genStatement body)
            terminateAnyway ret
    }

genModule :: AST.Program -> Module
genModule (AST.Program vars funcs) = defaultModule {
        moduleName = "program"
    ,   moduleDefinitions = (map genGlobalVariable vars)
                         ++ (map genFunction funcs)
                         ++ [getchar, putchar]
    }
    where
            getchar = GlobalDefinition $ functionDefaults {
                            name = Name "getchar"
                        ,   parameters = ([], False)
                        ,   returnType = i32
                        }

            putchar = GlobalDefinition $ functionDefaults {
                            name = Name "putchar"
                        ,   parameters = ([Parameter i32 (Name "c") []], False)
                        ,   returnType = i32
                        }

--------------------------------------------------------------------------------
--  Convert Program AST to Codegen
--------------------------------------------------------------------------------

genParameter :: AST.Variable -> Codegen Operand
genParameter v@(AST.Variable label _) = do
    new <- alloca
    setVar label new
    store new (local (Name label))

genLocalVariable :: AST.Variable -> Codegen ()
genLocalVariable (AST.Variable label _) = do
    new <- alloca
    setVar label new

genFunctionRef :: AST.Variable -> Codegen Operand
genFunctionRef (AST.Variable label AST.Global) = return $ global (Name label)
genFunctionRef (AST.Variable label _) = error "not a reference to a function"




genExpression :: AST.Expression -> Codegen Operand
genExpression (AST.UnaryExpression expr) = genSimpleExpression expr
genExpression (AST.BinaryExpression expr0 relOp expr1) = do
    a <- genSimpleExpression expr0
    b <- genSimpleExpression expr1
    cmp a b (toIP relOp)
    where   toIP AST.S = IP.SLT
            toIP AST.L = IP.SGT
            toIP AST.E = IP.EQ
            toIP AST.NE = IP.NE
            toIP AST.SE = IP.SLE
            toIP AST.LE = IP.SGE

genSimpleExpression :: AST.SimpleExpression -> Codegen Operand
genSimpleExpression (AST.TermSimpleExpression term) = genTerm term
genSimpleExpression (AST.OpSimpleExpression simpleExpr AST.Plus term) = do
    a <- genSimpleExpression simpleExpr
    b <- genTerm term
    add a b
genSimpleExpression (AST.OpSimpleExpression simpleExpr AST.Minus term) = do
    a <- genSimpleExpression simpleExpr
    b <- genTerm term
    sub a b

genTerm :: AST.Term -> Codegen Operand
genTerm (AST.FactorTerm factor) = genFactor factor
genTerm (AST.OpTerm term AST.Mul factor) = do
    a <- genTerm term
    b <- genFactor factor
    mul a b
genTerm (AST.OpTerm term AST.Div factor) = do
    a <- genTerm term
    b <- genFactor factor
    sdiv a b
genTerm (AST.NegTerm factor) = do
    val <- genFactor factor
    sub (literal 0) val


genFactor :: AST.Factor -> Codegen Operand
genFactor (AST.VariableFactor (AST.Variable label AST.Global)) = do
    load $ global (Name label)
genFactor (AST.VariableFactor (AST.Variable label AST.Local)) = do
    var <- getVar label
    load var
genFactor (AST.VariableFactor (AST.Variable label AST.Declaration)) = error "shouldn't be referencing stuffs"
genFactor (AST.LiteralFactor lit) = return $ literal lit
genFactor (AST.InvocationFactor var exprs) = do
    fn <- genFunctionRef var
    args <- mapM genExpression exprs
    call fn args
genFactor (AST.SubFactor expr) = genExpression expr
genFactor (AST.NotFactor factor) = do
    val <- genFactor factor
    cmp val (literal 0) IP.EQ

genStatement :: AST.Statement -> Codegen ()
genStatement (AST.Assignment (AST.Variable label AST.Global) expr) = void $ do
    let var = global (Name label)
    val <- genExpression expr
    store var val
genStatement (AST.Assignment (AST.Variable label AST.Local) expr) = void $ do
    var <- getVar label
    val <- genExpression expr
    store var val
genStatement (AST.Assignment (AST.Variable label AST.Declaration) expr) = error "shouldn't be referencing stuffs"
genStatement (AST.Return expr) = void $ do
    genExpression expr >>= ret
genStatement (AST.Invocation var exprs) = void $ do
    fn <- genFunctionRef var
    args <- mapM genExpression exprs
    call fn args
genStatement (AST.Compound stmts) = sequence_ (map genStatement stmts)
genStatement (AST.Branch cond tr fl) = void $ do
    ifThen <- addBlock "if.then"
    ifElse <- addBlock "if.else"
    ifExit <- addBlock "if.exit"

    -- entry
    ------------------
    condResult <- genExpression cond
    test <- cmp condResult (literal 0) IP.NE
    cbr test ifThen ifElse

    -- if.then
    ------------------
    setBlock ifThen
    genStatement tr                 -- Generate code for the true branch
    br ifExit                       -- Branch to the merge block
    ifThen <- getBlock

    -- if.else
    ------------------
    setBlock ifElse
    genStatement fl                 -- Generate code for the false branch
    br ifExit                       -- Branch to the merge block
    ifElse <- getBlock

    -- if.exit
    ------------------
    setBlock ifExit


genStatement (AST.Loop cond body) = void $ do
    whileBody <- addBlock "while.body"
    whileTest <- addBlock "while.test"
    whileExit <- addBlock "while.exit"

    -- entry
    ------------------
    br whileTest

    -- test
    ------------------
    setBlock whileTest
    condResult <- genExpression cond
    test <- cmp condResult (literal 0) IP.NE
    cbr test whileBody whileExit

    -- body
    ------------------
    setBlock whileBody
    genStatement body
    br whileTest

    -- exit
    ------------------
    setBlock whileExit
