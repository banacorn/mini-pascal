{
module Compiler.Syntax.Parser where

import Compiler.Syntax.Type
import Compiler.PreAST.Type
import Compiler.Type.Pipeline
import Compiler.Syntax.Lexer
import Control.Monad.Except
}

%name parse
%tokentype { Token }
%monad { Pipeline } { >>= } { return }
%error { parseError }

%token
    '('             { Token TokLParen _ }
    ')'             { Token TokRParen _ }
    ';'             { Token TokSemicolon _ }
    ':'             { Token TokColon _ }
    '.'             { Token TokPeriod _ }
    ','             { Token TokComma _ }
    id              { Token (TokID _) _ }
    int             { Token (TokInt _) _ }
    real            { Token (TokReal _) _ }
    typeInt         { Token TokTypeInt _ }
    typeReal        { Token TokTypeReal _ }
    typeVoid        { Token TokTypeVoid _ }
    progtok         { Token TokProgram _ }
    function        { Token TokFunction _ }
    begin           { Token TokBegin _ }
    return          { Token TokReturn _ }
    end             { Token TokEnd _ }
    var             { Token TokVar _ }
    of              { Token TokOf _ }
    if              { Token TokIf _ }
    then            { Token TokThen _ }
    else            { Token TokElse _ }
    while           { Token TokWhile _ }
    do              { Token TokDo _ }
    ':='            { Token TokAssign _ }
    '<'             { Token TokS _ }
    '>'             { Token TokL _ }
    '<='            { Token TokSE _ }
    '>='            { Token TokLE _ }
    '='             { Token TokEq _ }
    '!='            { Token TokNEq _ }
    '+'             { Token TokPlus _ }
    '-'             { Token TokMinus _ }
    '*'             { Token TokTimes _ }
    '/'             { Token TokDiv _ }
    not             { Token TokNot _ }
    '..'            { Token TokTo _ }

%%


program
    : progtok id '(' identifier_list ')' ';' variable_declarations subprogram_declarations compound_statement '.' {
        RawProgram (toSym $2) (reverse $4) (reverse $7) (reverse $8 ++ [FuncDec (Symbol "main" Unknown) [] RawVoidType [] $9])
    }


identifier_list
    : id                            { toSym $1 : [] }
    | identifier_list ',' id        { toSym $3 : $1 }


variable_declarations
    : {- empty -}                                               { [] }
    | variable_declarations var identifier_list ':' type ';'    { VarDec (reverse $3) $5 : $1 }

type
    : typeInt       { RawIntType }
    | typeReal      { RawRealType }
    | typeVoid      { RawVoidType }

subprogram_declarations
    : {- empty -}                                           { [] }
    | subprogram_declarations subprogram_declaration ';'    { $2 : $1 }


subprogram_declaration
    : function id ':' type ';' variable_declarations compound_statement
        { FuncDec (toSym $2) [] $4 $6 $7 }
    | function id '(' parameter_list ')' ':' type ';' variable_declarations compound_statement
        { FuncDec (toSym $2) (reverse $4) $7 $9 $10 }

parameter_list
    : identifier_list ':' type                      { Parameter $1 $3 : [] }
    | parameter_list ';' identifier_list ':' type   { Parameter $3 $5 : $1  }


compound_statement
    : begin statement_list end  { reverse $2 }

statement_list
    : {- empty -}                   { [] }
    | statement                     { [$1] }
    | statement_list ';' statement  { $3 : $1 }


statement
    : id ':=' expression                            { Assignment (toSym $1) $3 }
    | return expression                             { Return $2 }
    | id '(' expression_list ')'                    { Invocation (toSym $1) $3 }
    | compound_statement                            { Compound $1 }
    | if expression then statement else statement   { Branch $2 $4 $6 }
    | while expression do statement                 { Loop $2 $4 }

expression_list : {- empty -}                       { [] }
                | expression                        { $1 : [] }
                | expression_list ',' expression    { $3 : $1 }


expression
    : simple_expression                         { UnaryExpression $1 }
    | simple_expression relop simple_expression { BinaryExpression $1 $2 $3 }


simple_expression
    : term                              { TermSimpleExpression $1 }
    | simple_expression addop term      { OpSimpleExpression $1 $2 $3 }


term
    : factor            { FactorTerm $1 }
    | '-' factor        { NegTerm $2  }
    | term mulop factor { OpTerm $1 $2 $3 }


factor
    : id                            { VariableFactor (toSym $1) }
    | id '(' expression_list ')'    { InvocationFactor (toSym $1) $3 }
    | int                           { NumberFactor (toLiteral $1) }
    | real                          { NumberFactor (toLiteral $1) }
    | '(' expression ')'            { SubFactor $2 }
    | not factor                    { NotFactor $2 }


addop
    : '+'   { Plus }
    | '-'   { Minus }


mulop
    : '*'   { Mul }
    | '/'   { Div }



relop
    : '<'   { S }
    | '>'   { L }
    | '='   { E }
    | '<='  { SE }
    | '>='  { LE }
    | '!='  { NE }

{
parseError :: [Token] -> Pipeline a
parseError tokens = throwError (SyntaxErrorClass (maybeHead tokens))
    where   maybeHead [] = Nothing
            maybeHead (x:_) = Just x
}
