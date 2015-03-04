module Compiler.CodeGen where

import Compiler.Type.DSL
import Compiler.Class.Serializable

genCode :: ABT -> String
genCode (Program decs subprogs stmts) =
    "define void @main() {\n" ++
    "  %1 = alloca i32" ++
    "  store i32 100, i32* %1" ++
    "  %2 = load i32* %1" ++
    "  call i32 @putchar(i32 %2)\n" ++
    "  ret void\n" ++
    "}\n" ++
    "declare i32 @putchar(i32)\n"



    -- "\ndefine void @main() {\ncall i32 @putchar(i32 %1)\nret void\n}" ++
    -- "declare i32 @putchar(i32)"
--
--
-- genGlobalDeclaration :: Declaration -> String
-- genGlobalDeclaration (Declaration sym typ) =
--     "@" ++ symID sym ++ " = global "
