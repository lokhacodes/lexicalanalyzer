%{
#include<stdio.h>
int idcount=0;
int ncount=0;
%}

letter   [A-Za-z]
digit    [0-9]
hexaint 0x[A-F0-9]+
octalint 0[0-7]+
deciint   ([+-]?\d+)
binint   0b[01]+|[01]+
boolean True|False
identifier ($|_|{letter})((_|{letter})|{digit})* 
datatype  "int"|"char"|"float"|"double"|"long"|"short"|"String"|"boolean"|"void"|"byte" 
whitespace  [ \t\n]+
access "private"|"protected"|"public" 
for for{whitespace}+\([^)]*\)
%%

{boolean} {printf("\nBoolean literal: %s\n", yytext);}
{binint} {printf("\nBinary literal: %s\n", yytext);}
{octalint} {printf("\nOctal literal: %s\n", yytext);}
{hexaint} {printf("\nHexa literal: %s\n", yytext);}
{deciint} {printf("\nDecimal literal: %s\n", yytext);}
{letter}+\[\] {printf("\nArray list: %s\n", yytext);}
"return"{whitespace}+({digit}+|{datatype}|"null")   { printf("\nJava return keyword : %s", yytext);}
Math\.[a-z]+\([0-9]+\);|Math\.[a-z]+\([0-9]+,[0-9]+\); {printf("\nJava math class: %s\n", yytext);}
\(\([^)]*\)\s\?\s[A-Za-z0-9]+\s:\s[A-Za-z0-9]+\)  {printf("\nConditional Operator : %s\n", yytext);}
main\(String\[\]{whitespace}+args\) { printf("\nEntry point  : %s\n", yytext); }
[a-z]\.[a-z0-9]((\.[a-z0-9])+)?  {printf("\nUser defined packages : %s\n", yytext);}
"do"|"goto"|"if"|"else"|"for"|"while"|"switch"|"case"|"abstract"|"assert"|"break"|"continue"|"default"|"Enum"|"extends"|"final"|"finally"|"implements"|"import"|"instanceof"|"interface"|"native"|"new"|"package"|"return"|"static"|"strictfp"|"super"|"synchronized"|"to"|"transitive"|"uses"|"this"|"throw"|"throws"|"transient"|"volatile"|"with" {printf("\nKeyword : %s", yytext);}
{access} {printf("\nAccess Specifier : %s", yytext);}
"java.".* {printf ("\nImported built in packages : %s", yytext);}
"System.out.println"|"System.out.print" {printf("\nPrint statement : %s", yytext);}
"out"|"in" {printf ("\nObject : %s",yytext);}
"[]"|"["|"]" {printf("\nBrackets: %s\n",yytext);}
"()"|"("|")" {printf("\nParenthesis: %s\n",yytext);}
"{}"|"{"|"}" {printf("\nBraces: %s\n",yytext);}
{datatype} {printf("\nDatatype: %s\n",yytext);}
"." {printf("\nDot Operator : %s",yytext);}
"="|"+="|"-="|"*="|"/="|"%="   {printf("\nAssignment operator: %s\n",yytext);}
"+"|"-"|"*"|"/"|"%" {printf("\nArithmetic operator: %s\n",yytext);}
"<"|"<="|">"|">="|"=="|"!=" {printf("\nRelational operator: %s\n",yytext);}
"&&" {printf("\nLogical AND operator: %s\n",yytext);}
"||" {printf("\nLogical OR operator: %s\n",yytext);}
"&"|"~"|"^" {printf("\nBitwise operator: %s\n",yytext);}
"<<"|">>"|">>>" {printf("\nShift and bitwise operator: %s\n",yytext);}
"++"|"--" {printf("\nIncrement/decrement operator: %s\n",yytext);}
"!" {printf("\nLogical NOT operator: %s\n",yytext);}
"?:" {printf("\nTernary or conditional operator: %s\n",yytext);}
"//".* {printf("\nSingle line comment : %s",yytext);}
"/*"(.|\n)*"*/" {printf("\nMultiple Line Comment : %s",yytext);}
\".*\" {printf("\nString : %s ",yytext);}
{digit}*\.{digit}+    {printf("\nFloat Constant : %s ",yytext);}
{digit}*       {printf("\nInteger Cosntant: %s ",yytext);}
({digit})+((\.({digit})+)?("e^"[+-]?({digit})+)?)?    {printf("\nNumber: %s ",yytext);}
(%("d"|"f"|"Lf"|"s"|"lf"|"o"|"u"|"x"|"p"|"X"|"i"|"c"|"e")) {printf("\nFormat Specifier: %s ",yytext);}
'{letter}'    {printf("\nCharacter Constant : %s",yytext);}
{identifier} {idcount++;printf("Identifier:  %s\nLength of the string %d\n",yytext,yyleng);}
{letter}({letter}|{digit})*/\(.+\)  {printf("\nFunction: %s ",yytext);}
";" {printf("\nStatement terminator: %s\n",yytext);}
"@"|"_"|"'"|":" {printf("\nSpecial character: %s\n",yytext);}
"," {printf("\nComma: %s\n",yytext);}
"#" {printf("\npreprocessor: %s\n",yytext);}
"~" {printf("\nTilde: %s\n",yytext);}
"." {printf("\nPeriod: %s\n",yytext);}
"\t"|"\b"|"\f"|"\n"|"\r" {printf("\nEscape sequence horizontal tab: %s\n",yytext);}
\([^)]*\)\s*->\s*\{[^}]*\}  {printf("\nLambda expression: %s\n", yytext);}
{datatype}{whitespace}{identifier}  { printf("\nVariable Creation : %s", yytext);}
({access}{whitespace}+)?"class"{whitespace}+{identifier}  { printf("\nDefining Class : %s", yytext);}
{for} {printf("\nfor loop : %s",yytext);}
[A-Z][a-z]+([A-Z][a-z]+)?       {printf("\nClass name or interface name: %s\n", yytext);}
[A-Z_]+ {printf("\nConstant name: %s\n", yytext);}
"Scanner"{whitespace}+[A-Za-z0-9]+{whitespace}+={whitespace}+"new"{whitespace}+"Scanner"\("System"\."in"\);       {printf("\nObject for User input : %s\n", yytext);}
({letter}|{digit})+{whitespace}*({letter}|{digit})+{whitespace}\={whitespace}*({letter}|{digit})+{whitespace}*({letter}|{digit})+\(\)\; {printf("\nCreation of Object: %s\n", yytext);}
"get"|"set"  {printf("\nEncapsulation: %s\n", yytext);}
({letter}+{whitespace}*\(\))|({letter}+{whitespace}*\(\)) {printf("\nMethod or constructor: %s\n", yytext);}
[a-z]+{whitespace}*\([^)]*\) { printf("\nConditionals: %s\n", yytext); }
%%

int yywrap()
{
    return 1;
}

int main()
{
    yyin= fopen("index.txt","r");
printf("Here in file:\n");
        yylex();
        return 0;
}