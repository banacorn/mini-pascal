module Compiler.DSL.RawAST.Statement (restoreStatement) where

import Compiler.Type.DSL
import Compiler.Type.Symbol

import Control.Monad.State
--
restoreStatement :: RawProgram -> Program a b -> Program a (Statement b)
restoreStatement (RawProgram _ _ _ subprogs stmts) (Program decs subprogs' stmts') = Program
    decs
    (map2 restoreSubprogramStatement subprogs subprogs')
    (Subprogram compoundDecs (restoreCompoundStmt stmts compoundStmts))
    where   Subprogram compoundDecs compoundStmts = stmts'

restoreSubprogramStatement :: RawSubprogram -> Subprogram a b -> Subprogram a (Statement b)
restoreSubprogramStatement (FuncDec _ _ _ _ stmts) (Subprogram decs stmts') = Subprogram decs (restoreCompoundStmt stmts stmts')

restore' :: Restorable n => n a -> [b] -> n b
restore' s stack = evalState (restore s) stack

restoreCompoundStmt :: Restorable n => [n a] -> [b] -> [n b]
restoreCompoundStmt xs stack = evalState (mapM restore xs) stack

--------------------------------------------------------------------------------
-- Class & Instances

class Restorable n where
    restore :: n a -> State [b] (n b)

pop :: State [b] b
pop = do
    stack <- get
    put (tail stack)
    return (head stack)

instance Restorable Statement where
    restore (Assignment _ expr) =  do
        sym' <- pop
        expr' <- restore expr
        return (Assignment sym' expr')
    restore (Return expr) = restore expr >>= return . Return
    restore (Invocation sym exprs) = do
        sym' <- pop
        exprs' <- mapM restore exprs
        return (Invocation sym' exprs')
    restore (Compound stmts) = mapM restore stmts >>= return . Compound
    restore (Branch predExpr thenStmt elseStmt) = do
        predExpr' <- restore predExpr
        thenStmt' <- restore thenStmt
        elseStmt' <- restore elseStmt
        return (Branch predExpr' thenStmt' elseStmt')
    restore (Loop expr stmt) = do
        expr' <- restore expr
        stmt' <- restore stmt
        return (Loop expr' stmt')

instance Restorable Expression where
    restore (UnaryExpression expr) = restore expr >>= return . UnaryExpression
    restore (BinaryExpression expr0 op expr1) = do
        expr0' <- restore expr0
        expr1' <- restore expr1
        return (BinaryExpression expr0' op expr1')

instance Restorable SimpleExpression where
    restore (TermSimpleExpression term) = restore term >>= return . TermSimpleExpression
    restore (OpSimpleExpression expr op term) = do
        expr' <- restore expr
        term' <- restore term
        return (OpSimpleExpression expr' op term')

instance Restorable Term where
    restore (FactorTerm factor) = restore factor >>= return . FactorTerm
    restore (OpTerm term op factor) = do
        term' <- restore term
        factor' <- restore factor
        return (OpTerm term' op factor')
    restore (NegTerm factor) = restore factor >>= return . NegTerm

instance Restorable Factor where
    restore (ArrayAccessFactor sym) = do
        sym' <- pop
        return (ArrayAccessFactor sym')
    restore (InvocationFactor sym exprs) = do
        sym' <- pop
        exprs' <- mapM restore exprs
        return (InvocationFactor sym' exprs')
    restore (NumberFactor num) = return (NumberFactor num)
    restore (SubFactor expr) = restore expr >>= return . SubFactor
    restore (NotFactor factor) = restore factor >>= return . NotFactor
