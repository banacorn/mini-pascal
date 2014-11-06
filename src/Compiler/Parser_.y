{
module Compiler.Parser where
import Compiler.Types
}

%name parse
%tokentype { Token }
%error { parseError }

%token
    '('             { TokLParen }
    ')'             { TokRParen }
    ';'             { TokSemicolon }
    ':'             { TokColon }
    '.'             { TokPeriod }
    ','             { TokComma }
    '['             { TokLSB }
    ']'             { TokRSB }
    id              { TokID $$ }
    string          { TokStr $$ }
    num             { TokNum $$ }
    integer         { TokTypeInt }
    real            { TokTypeReal }
    progtok         { TokProgram }
    function        { TokFunction }
    procedure       { TokProc }
    begin           { TokBegin }
    end             { TokEnd }
    var             { TokVar }
    array           { TokArr }
    of              { TokOf }
    if              { TokIf }
    then            { TokThen }
    else            { TokElse }
    while           { TokWhile }
    do              { TokDo }
    ':='            { TokAssign }
    '<'             { TokS }
    '>'             { TokL }
    '<='            { TokSE }
    '>='            { TokLE }
    '='             { TokEq }
    '!='            { TokNEq }
    '+'             { TokPlus }
    '-'             { TokMinus }
    '*'             { TokTimes }
    '/'             { TokDiv }
    not             { TokNot }
    '..'            { TokTo }

%%

program : progtok id '(' identifier_list ')' ';' declarations subprogram_declarations compound_statement '.' {
    Program $2 $4 $7 $8 $9
}


identifier_list : id                            { $1 }
                | identifier_list ',' id        { $3 : $1 }


declarations    : {- empty -}                                       { [] }
                | declarations var identifier_list ':' type ';'     { Declaration $2 $3 $5 : $1 }


type    : standard_type                          { StdType $1 }
        | array '[' num '..' num ']' of type     { ArrayType ($3, $5) $8 }


standard_type   : integer       { IntType }
                | real          { RealType }
                | string        { StringType }


subprogram_declarations : {- empty -}                                           { [] }
                        | subprogram_declarations subprogram_declaration ';'    { $2 : $1 }


subprogram_declaration : subprogram_head declarations compound_statement { SubprogDec $1 $2 $3 }

subprogram_head : function id arguments ':' standard_type ';'       { SubprogHeadFunc $2 $3 $5 }
                | procedure id arguments ';'                        { SubprogHeadProc $2 $3}


arguments   : {- empty -}               { EmptyArguments }
            | '(' parameter_list ')'    { Arguments $2 }


parameter_list  : identifier_list ':' type                      { [Param $1 $3] }
                | parameter_list ';' identifier_list ':' type   { Param $3 $5 : $1  }


compound_statement : begin optional_statements end  { $2 }


optional_statements : {- empty -}       { [] }
                    | statement_list    { $1 }


statement_list  : statement                     { [$1] }
                | statement_list ';' statement  { $3 : $1 }


statement   : variable ':=' expression                      { VarStmt $1 $3 }
            | procedure_statement                           { ProcStmt $1 }
            | compound_statement                            { CompStmt $1 }
            | if expression then statement else statement   { BranchStmt $2 $4 $6 }
            | while expression do statement                 { LoopStmt $2 $4 }


variable : id tail  { Variable $1 $2 }

tail    : {- empty -}                   { [] }
        | '[' expression ']' tail       { $2 : $4 }


procedure_statement : id                            { ProcedureStmtOnlyID $1 }
                    | id '(' expression_list ')'    { ProcedureStmtWithExprs $3 }


expression_list : expression                        { [$1] }
                | expression_list ',' expression    { $3 : $1 }


expression  : simple_expression                         { UnaryExpr $1 }
            | simple_expression relop simple_expression { BinaryExpr $1 $2 $3 }


simple_expression   : term                              { SimpleExprTerm $1 }
                    | simple_expression addop term      { SimpleExprOp $1 $2 $3 }


term    : factor            { FactorTerm $1 }
        | term mulop factor { OpTerm $1 $2 $3 }


factor  : id tail                       { IDSBFactor $1 $2 }
        | id '(' expression_list ')'    { IDPFactor $1 $3 }
        | num                           { NumFactor $1 }
        | '(' expression ')'            { PFactor $2 }
        | not factor                    { NotFactor $2 }


addop   : '+'   { Plus }
        | '-'   { Minus }


mulop   : '*'   { Mul }
        | '/'   { Div }



relop   : '<'   { S }
        | '>'   { L }
        | '='   { E }
        | '<='  { SE }
        | '>='  { LE }
        | '!='  { NE }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"

}
