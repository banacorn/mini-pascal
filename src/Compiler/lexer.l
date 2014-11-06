%{

#include <stdio.h>

#define   AND               1
#define   ARRAY             2
#define   CASE              3
#define   CONST             4
#define   DIV               5
#define   DO                6
#define   DOWNTO            7
#define   ELSE              8
#define   END               9
#define   EXTERNAL          10
#define   FOR               11
#define   FORWARD           12
#define   FUNCTION          13
#define   GOTO              14
#define   IF                15
#define   IN                16
#define   LABEL             17
#define   MOD               18
#define   NIL               19
#define   NOT               20
#define   OF                21
#define   OR                22
#define   OTHERWISE         23
#define   PACKED            24
#define   PBEGIN            25
#define   PFILE             26
#define   PROCEDURE         27
#define   PROGRAM           28
#define   RECORD            29
#define   REPEAT            30
#define   SET               31
#define   THEN              32
#define   TO                33
#define   TYPE              34
#define   UNTIL             35
#define   VAR               36
#define   WHILE             37
#define   WITH              38
#define   IDENTIFIER        39
#define   ASSIGNMENT        40
#define   CHARACTER_STRING  41
#define   COLON             42
#define   COMMA             43
#define   DIGSEQ            44
#define   DOT               45
#define   DOTDOT            46
#define   EQUAL             47
#define   GE                48
#define   GT                49
#define   LBRAC             50
#define   LE                51
#define   LPAREN            52
#define   LT                53
#define   MINUS             54
#define   NOTEQUAL          55
#define   PLUS              56
#define   RBRAC             57
#define   REALNUMBER        58
#define   RPAREN            59
#define   SEMICOLON         60
#define   SLASH             61
#define   STAR              62
#define   STARSTAR          63
#define   UPARROW           64
#define   notEQUAL          65
#define   COMMENT           66
#define   NUM               67

int line_no = 1;
int char_pos = 1;

%}

/*
  make alphabets case-insensitive
  with flex v2.5.34 or newer one can use perlish (?i:ab) instead of [aA][bB]
*/

A [aA]
B [bB]
C [cC]
D [dD]
E [eE]
F [fF]
G [gG]
H [hH]
I [iI]
J [jJ]
K [kK]
L [lL]
M [mM]
N [nN]
O [oO]
P [pP]
Q [qQ]
R [rR]
S [sS]
T [tT]
U [uU]
V [vV]
W [wW]
X [xX]
Y [yY]
Z [zZ]

NQUOTE  [^']|"\\'"
NDBQUOTE  [^"\""]|"\\\""
DIGIT   [0-9]
SIGN    "-"?
INTEGER {SIGN}("0"|[1-9]{DIGIT}*)
REAL    {SIGN}([1-9]{DIGIT}*|"0")"."{DIGIT}+
SCINOT  [-+]?{DIGIT}*\.?{DIGIT}+([eE][-+]?{DIGIT}+)?
%%

{REAL}                        { char_pos += strlen(yytext); return(NUM); }
{INTEGER}                     { char_pos += strlen(yytext); return(NUM); }
{SCINOT}                      { char_pos += strlen(yytext); return(NUM); }
"\""{NDBQUOTE}*"\"" { char_pos += strlen(yytext); return(NUM); }
'({NQUOTE}|'')+'              { char_pos += strlen(yytext); return(NUM); }
{A}{R}{R}{A}{Y}               { char_pos += strlen(yytext); return(ARRAY); }
{D}{O}                        { char_pos += strlen(yytext); return(DO); }
{E}{L}{S}{E}                  { char_pos += strlen(yytext); return(ELSE); }
{E}{N}{D}                     { char_pos += strlen(yytext); return(END); }
{F}{U}{N}{C}{T}{I}{O}{N}      { char_pos += strlen(yytext); return(FUNCTION); }
{I}{F}                        { char_pos += strlen(yytext); return(IF); }
{N}{I}{L}                     { char_pos += strlen(yytext); return(NIL); }
{N}{O}{T}                     { char_pos += strlen(yytext); return(NOT); }
{O}{F}                        { char_pos += strlen(yytext); return(OF); }
{P}{R}{O}{C}{E}{D}{U}{R}{E}   { char_pos += strlen(yytext); return(PROCEDURE); }
{P}{R}{O}{G}{R}{A}{M}         { char_pos += strlen(yytext); return(PROGRAM); }
{T}{H}{E}{N}                  { char_pos += strlen(yytext); return(THEN); }
{V}{A}{R}                     { char_pos += strlen(yytext); return(VAR); }
{W}{H}{I}{L}{E}               { char_pos += strlen(yytext); return(WHILE); }
([a-zA-Z]|"_")([a-zA-Z0-9])*  { char_pos += strlen(yytext); return(IDENTIFIER); }
":="                          { char_pos += strlen(yytext); return(ASSIGNMENT); }
":"                           { char_pos += strlen(yytext); return(COLON); }
","                           { char_pos += strlen(yytext); return(COMMA); }
"."                           { char_pos += strlen(yytext); return(DOT); }
".."                          { char_pos += strlen(yytext); return(DOTDOT); }
"="                           { char_pos += strlen(yytext); return(EQUAL); }
"!="                          { char_pos += strlen(yytext); return(notEQUAL); }
">="                          { char_pos += strlen(yytext); return(GE); }
">"                           { char_pos += strlen(yytext); return(GT); }
"["                           { char_pos += strlen(yytext); return(LBRAC); }
"<="                          { char_pos += strlen(yytext); return(LE); }
"("                           { char_pos += strlen(yytext); return(LPAREN); }
"<"                           { char_pos += strlen(yytext); return(LT); }
"-"                           { char_pos += strlen(yytext); return(MINUS); }
"+"                           { char_pos += strlen(yytext); return(PLUS); }
"]"                           { char_pos += strlen(yytext); return(RBRAC); }
")"                           { char_pos += strlen(yytext); return(RPAREN); }
";"                           { char_pos += strlen(yytext); return(SEMICOLON); }
"//"[^\r\n]*(\r\n)            { char_pos += strlen(yytext); printf( "%s\n", yytext); line_no++; }
"/"                           { char_pos += strlen(yytext); return(SLASH); }
"*"                           { char_pos += strlen(yytext); return(STAR); }
[ \t\f]                       { char_pos += 1 ;}
\r         ;
\n                            { line_no++; char_pos = 1; }
.                             {fprintf(stderr,"Lexical analyzer error at line %d : %s\n",line_no,yytext);}

%%

int main(int argc, char** argv) {
  int i, tok;
  yyin = stdin;
  for (i = 0; 1==1; i ++) {
    tok = yylex();
    fprintf(stdout, "(L %d C %d) type:%d   %s\n", line_no, char_pos - strlen(yytext), tok, yytext);
  }
  return(0);
} /* end of main */

yywrap() {
  fclose(yyin);
  exit(0);
}
