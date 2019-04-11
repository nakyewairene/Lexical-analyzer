%option noyywrap
%{
#include <stdio.h>
int countKeywords=0;
int countIdentifiers=0;
int countNumericals=0;
int countPreprocessors = 0;
int countOpenningParenthesis = 0;
int countClosingParenthesis = 0;
int countOpenningCurlyBrackets = 0;
int countClosingCurlyBrackets = 0;
int countOpenningSquareBracket = 0;
int countClosingSquareBracket = 0;
int countDelimiter = 0;
int countTermination = 0;
int countStringLiteral = 0;
int countAnd = 0;
int countEqualOperator = 0;
int countlessThan = 0;
int countIncrement = 0;
int countEquivalence = 0;
int countPlusOperator = 0;
int countNumberOfCommentsIngnored = 0;
int countAddAsign = 0;
int countNotEqualOperator = 0;
int countGreaterThanOperator = 0;
int countMultiplyAssign     = 0;
int countDecrement          = 0;
int countLessThanOrEqualTo  = 0;
int countGreaterThanOrEqualTo=0;
int countmultiplicationOperator=0;
%}
whitespace	[ \n\t\r]
preprocessor    #.*
comment         "/*"[.|\n]*"*/"|"//".|"/"(.[\n].)"/"
letter		[a-zA-Z_]
digit		[0-9]
operator	[+-*/]
stringLiteral {letter}?\"(\\.|[^\\"])*\"
Keyword     if|else|while|int|switch|for|char|return|break|double|do|long|void|struct|case|const|typedef|goto
openningParenthesis [(]
closingParenthesis [)]
openningCurlyBracket [{]
closingCurlyBracket    [}]
openningSquareBracket   [[]
closingSquareBracket    []]
delimiter    [,]
termination [;]
and [&]
multiplicationOperator [*]
equalsOperator  [=]
lessThan        [<]
plusOperator    [+]
increment       "++"
decrement       "--"
equivalence     "=="
addAssign       "+="
notEqualOperator   "!="
greaterThanOperator [>]
multiplyAssign      "*="
lessThanOrEqualTo   "<="
greaterThanOrEqualTo ">="

%%
{whitespace}+	{/*skip white space*/}
{preprocessor} { countPreprocessors++; printf("\tPREPROCESSOR: %s\n",yytext);}
{comment}       {countNumberOfCommentsIngnored++;}
{Keyword} {countKeywords++;printf("Keyword: %s \n", yytext);}
{letter}({letter}|{digit})* {countIdentifiers++;printf("Identifiers: %s \n", yytext);}
{digit}*|{digit}*"."{digit}*	{countNumericals++;printf("Constant:%s\n",yytext);}
{openningParenthesis} {countOpenningParenthesis++;}
{closingParenthesis} {countClosingParenthesis++;}
{openningCurlyBracket} {countOpenningCurlyBrackets++;}
{closingCurlyBracket} {countClosingCurlyBrackets++;}
{openningSquareBracket} {countOpenningSquareBracket++;}
{closingSquareBracket} {countClosingSquareBracket++;}
{delimiter} {countDelimiter++;}
{termination} {countTermination++;}
{stringLiteral} {countStringLiteral++;printf("String Literal:%s\n",yytext);}
{and} {countAnd++;printf("Operator:%s\n",yytext);}
{equalsOperator} {countEqualOperator++;printf("Operator:%s\n",yytext);}
{lessThan} {countlessThan++;printf("Operator:%s\n",yytext);}
{increment} {countIncrement++;printf("Operator:%s\n",yytext);}
{equivalence} {countEquivalence++;printf("Operator:%s\n",yytext);}
{plusOperator} {countPlusOperator++;printf("Operator:%s\n",yytext);}
{addAssign} {countAddAsign++;printf("Operator:%s\n",yytext);}
{notEqualOperator} {countNotEqualOperator++;printf("Operator:%s\n",yytext);}
{greaterThanOperator} {countGreaterThanOperator++;printf("Operator:%s\n",yytext);}
{multiplyAssign} {countMultiplyAssign++;printf("Operator:%s\n",yytext);}
{decrement} {countDecrement++;printf("Operator:%s",yytext);}
{lessThanOrEqualTo} {countLessThanOrEqualTo++;printf("Operator:%s\n",yytext);}
{greaterThanOrEqualTo} {countGreaterThanOrEqualTo++;printf("Operator:%s\n",yytext);}
{multiplicationOperator} {countmultiplicationOperator++;printf("Operator:%s\n",yytext);}
.	{printf("invalid: %s \n", yytext);}


%%
int main(){
char file[25];
 
   printf("Enter file name: ");
  // gets(file);
  scanf("%s",&file);


yyin = fopen(file, "r");
yyout = fopen("Symbol table.txt", "w");
yylex();
 



printf("\n\t PREPROCESSORS: \t \t       %d \n", countPreprocessors);
printf("\t Number of comments: \t \t    %d \n", countNumberOfCommentsIngnored);
int totalIdentifiers = 0;

totalIdentifiers = countKeywords +  countIdentifiers + countNumericals + countOpenningParenthesis 
    + countClosingParenthesis + countOpenningCurlyBrackets +countClosingCurlyBrackets
    + countOpenningSquareBracket + countClosingSquareBracket + countDelimiter + countTermination
    + countStringLiteral +countAnd + countEqualOperator + countlessThan + countIncrement + countEquivalence
    + countPlusOperator + countAddAsign + countNotEqualOperator + countMultiplyAssign + countGreaterThanOperator
    + countDecrement + countLessThanOrEqualTo;
    printf("\tTOTAL TOKENS FOUND:\t\t %d \n\n", totalIdentifiers);
printf("\n************************************************************\n");

printf("\t TOKEN CLASS \t\t\t\t NO. OF TOKENS FOUND \n");
printf("\t Keywords: \t\t\t\t         %d \n", countKeywords);
printf("\t Identifiers: \t\t\t\t         %d \n", countIdentifiers);
printf("\t Numerials: \t\t\t\t         %d \n", countNumericals);
printf("\t openningParenthesis: \t\t\t\t %d \n", countOpenningParenthesis);
printf("\t closingParenthesis: \t\t\t\t %d \n", countClosingParenthesis);
printf("\t openningCurlyBracket: \t\t\t\t %d \n", countOpenningCurlyBrackets);
printf("\t closingCurlyBracket: \t\t\t\t %d \n", countClosingCurlyBrackets);
printf("\t openningSquareBracket:\t\t\t         %d \n", countOpenningSquareBracket);
printf("\t closingSquareBracket: \t\t\t\t %d \n", countClosingSquareBracket);
printf("\t delimiter: \t\t\t\t         %d \n", countDelimiter);
printf("\t termination: \t\t\t\t         %d \n", countTermination);
printf("\t stringLiteral: \t\t\t\t %d \n", countStringLiteral);
printf("\t and: \t\t\t\t                 %d \n", countAnd);
printf("\t equalsOperator: \t\t\t\t %d \n", countEqualOperator);
printf("\t lessThan: \t\t\t\t         %d \n", countlessThan);
printf("\t increment: \t\t\t\t         %d \n", countIncrement);
printf("\t equivalence: \t\t\t\t         %d \n", countEquivalence);
printf("\t plusOperator: \t\t\t\t         %d \n", countPlusOperator);
printf("\t addAssign: \t\t\t\t         %d \n", countAddAsign);
printf("\t notEqualOperator: \t\t\t\t %d \n", countNotEqualOperator);
printf("\t multiplyAssign: \t\t\t\t %d \n", countMultiplyAssign);
printf("\t greaterThanOperator: \t\t\t\t %d \n", countGreaterThanOperator);
printf("\t decrement: \t\t\t\t         %d \n", countDecrement);
printf("\t lessThanOrEqualTo: \t\t\t\t %d \n", countLessThanOrEqualTo  );
printf("\t greaterThanOrEqualTo: \t\t\t\t %d \n", countGreaterThanOrEqualTo  );
system("PAUSE");
return 0;
}