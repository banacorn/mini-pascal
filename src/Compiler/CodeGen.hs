module Compiler.CodeGen where

import Compiler.Type.DSL
import Compiler.Type.Symbol
import Compiler.Type.Type
import Compiler.Class.Serializable

import Control.Monad.State


genCode :: ABT -> String
genCode (Program decs subprogs stmts) = paragraph $
        0 >>>> globalVarDeclarations
    ++  0 >>>> subprogramDeclarations
    ++  0 >>>>  [   "define void @main() {"
                ,   "  %1 = alloca i32"
                ,   "  store i32 100, i32* %1"
                ,   "  %2 = load i32* %1"
                ,   "  ret void"
                ,   "  call i32 @putchar(i32 %2)"
                ,   "  ret void"
                ,   "}"
                ,   "declare i32 @putchar(i32)"
                ]
    where   numSubprogram = length subprogs
            numGlobalDec  = length decs - numSubprogram

            globalVarDeclarations = map genGlobalDeclaration (take numGlobalDec decs)
            subprogramDeclarations = map2 genSubprogram subprogs (drop numGlobalDec decs)
    -- "\ndefine void @main() {\ncall i32 @putchar(i32 %1)\nret void\n}" ++
    -- "declare i32 @putchar(i32)"
--

genType :: Domain -> String
genType (IntType) = "i32"
genType (RealType) = "double"
genType (VoidType) = "void"

genGlobalDeclaration :: Declaration -> String
genGlobalDeclaration (Declaration sym (BasicType IntType)) =
    "@" ++ symID sym ++ " = global i32 0"
genGlobalDeclaration (Declaration sym (BasicType RealType)) =
    "@" ++ symID sym ++ " = global double 0.0"

genSubprogram :: Subprogram Declaration (Statement Value) -> Declaration -> String
genSubprogram (Subprogram decs stmts) (Declaration sym (SubprogramType types)) = paragraph $
        0   >>>> ["define " ++ genType retType ++ " @" ++ funcName ++ "() {"]
    -- ++  1   >>>> genCompoundStmt stmts
    ++  1   >>>> retVoid
    ++  0   >>>> ["}"]
    where   retType = last types
            funcName = getID sym

            retVoid = if retType == VoidType then ["ret void"] else []

hasReturnStmt :: [Statement Value] -> Bool
hasReturnStmt = any isReturnStmt
    where   isReturnStmt (Return _) = True
            isReturnStmt _          = False

genCompoundStmt :: [Statement Value] -> [String]
genCompoundStmt _ = [""]

-- genStatement :: Statement Value -> [String]
-- genStatement (Return e) =


class CodeGen a where
    gen :: a -> GenBlock a


type GenBlock = State Block
data Block = Block
    {   blockCount :: Int           -- for unamed variables
    ,   blockStack :: [String]
    }

genBlock :: State Block a -> Block -> [String]
genBlock f s = blockStack (execState f s)

freshVar :: GenBlock Int
freshVar = do
    i <- gets blockCount
    modify $ \s -> s { blockCount = i + 1 }
    return $ i + 1
    -- modify
