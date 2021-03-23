grammar myGrammar;

program : library* mainBlock;

library: (Import) libraryName ';' ;
libraryName: Identifier;


mainBlock : '{' mainBody '}';
mainBody: class*;
class: Class className ':' '<' classBody '>';
className: Identifier;
classBody: (variableInit | function)*;


variableInit: variableType variableName (assignment const_expression)? (',' variableName (assignment const_expression)? )* ';';
variableType : Int | Floatt | Bool;
variableName : Identifier;

function : Function functionName '(' functionInput ')' '<' functionBody? '>';
functionName: Identifier;
functionInput: (variableType variableName (',' variableType variableName)*)?;
functionBody: (variableInit | variableAssign | if | for | while | switch_case )+;

variableAssign : variableName assignment expression ';';
variableAssign0 : variableName assignment expression;
assignment: '=' | '**=' | '/=' | '//=' | '%=' | '+=' | '-=' | '*=';


/*
* docs/parseTree1.png
*
// not to allow expression between 2 assignment
expression:
    expression0
    |variableName assign
    ;

assign:(assignment expression0)| assignment variableName assign;

expression0:
    primary
    |'(' expression0 ')'
    |<assoc=right>expression0 '**' expression0
    |'~' expression0
    |('-'|'+') expression0
    |expression0 ('*'|'/'|'%'|'//') expression0
    |expression0 ('+'|'-') expression0
    |expression0 '#' expression0
    |expression0 ('>>'|'>>') expression0
    |expression0 '_' expression0
    |expression0 ('&'|'|'|'^') expression0
    |expression0 ('=='|'!='|'<>') expression0
    |expression0 ('<'|'<='|'>'|'>=') expression0
    | (Not) expression0 |expression0 (And|Or) expression0
    ;
*/


/*
* docs/parseTree2.png
*
expression:(expression2 logical) | expression2;
expression2: (variableName assignment)*;
logical: ((com logical2)|logical2) | ( (logical3 com)|logical3);
logical2: ( (And|Or) com)*;
logical3: (Not com)*;
com: (equal com2) | com2;
com2: ( ('<'|'<='|'>'|'>=') equal)*;
equal: (biti equal2) | equal2;
equal2: ( ('=='|'!='|'<>') biti)*;
biti: underline biti2;
biti2: ( ('&' | '|' | '^') underline)*;
underline: bit_shift underline2;
underline2: ( '_' bit_shift)*;
bit_shift: sharp bit_shift2;
bit_shift2: ( ('<<'|'>>') sharp)*;
sharp:add sharp2;
sharp2: ('#' add)*;
add: numeric add2;
add2: ( ('+' | '-') numeric)*;
numeric: sign numeric2;
numeric2: ( ('*' | '/' | '//' | '%') sign)*;
sign: (sign2 complement) | sign2;
sign2: ( '+' '-' complement)*;
complement: complement2 power | complement2;
complement2: ('~' power)*;
power: parant power2;
power2: ('**' parant)*;
parant: ( '(' expression ')' ) | Integer | primary;
*/


/*
* docs/parseTree3(final).png
*/
expression: variableName assignment expression|logical;
logical: logical (And|Or) com|com | Not com;
com: com ('<'|'<='|'>'|'>=') equal | equal;
equal: equal ('=='|'!='|'<>') biti|biti;
biti: biti ('&' | '|' | '^') underline | underline;
underline: underline '_' shift | shift;
shift: shift ('>>'|'<<') sharp | sharp;
sharp: sharp '#' addmin | addmin;
addmin: addmin ('+'|'-') mul | mul;
mul: mul ('*'|'/'|'//'|'%') sign|sign;
sign: ('+'|'-') complement|complement;
complement: '~' power | power;
power: parant '**' power | parant;
parant: '(' expression ')' | primary;


const_expression:variableName assignment const_expression|const_logical;
const_logical: const_logical (And|Or) const_com|const_com | Not const_com;
const_com: const_com ('<'|'<='|'>'|'>=') const_equal |const_equal;
const_equal: const_equal ('=='|'!='|'<>') const_biti|const_biti;
const_biti: const_biti ('&' | '|' | '^') const_underline | const_underline;
const_underline: const_underline '_' const_shift | const_shift;
const_shift: const_shift ('>>'|'<<') const_sharp | const_sharp;
const_sharp: const_sharp '#' const_addmin | const_addmin;
const_addmin: const_addmin ('+'|'-') const_mul | const_mul;
const_mul: const_mul ('*'|'/'|'//'|'%') const_sign|const_sign;
const_sign: ('+'|'-') const_complement|const_complement;
const_complement: '~' const_power | const_power;
const_power: const_parant '**' const_power | const_parant;
const_parant: '(' const_expression ')' | const_primary;
const_primary: Integer | Float | Scientific | True| False| Null|Iota;


primary: variableName| Integer | Float | Scientific | True| False| Null|Iota;


for: For '(' ( variableType? variableAssign0 (',' variableAssign0)*)? ';' condition0 ';' increment? ')' '<' (functionBody)* '>';

condition0 :
 '(' condition0 ')'|
 condition0 (conditionSym) condition0|
 compare;

compare: expression compareSym expression;
compareSym: '<' | '<=' | '>' | '>=' | '==' | '!=' | '<>' ;
conditionSym: '&&' | '||';
increment: (variableAssign0 | (variableName ('++'| '--'))) (',' variableAssign0 | (variableName ('++'| '--')))*;


if: If '(' condition0 ')' '<' functionBody? '>'  elif*  else?;
elif: (Else If '(' condition0 ')' '<' functionBody? '>');
else: Else '<' functionBody? '>';


while: While '(' condition0 ')' '<' (functionBody)* '>';



switch_case: Switch '(' expression ')' '<' cases '>';
cases: (case)*;
case:Case case_expression ':' (functionBody | Break)+;
case_expression: const_logical;


//word: ( Letter(Letter|Function|Import|Class|Int|Floatt|Bool|True|False|Null)*) | ((Letter|Function|Import|Class|Int|Floatt|Bool|True|False|Null)*Letter);

E:'e';
Import:'import';
Class:'class';
Int: 'int';
Floatt:'float';
Bool:'bool';
Function:'Function';
True:'true';
False:'false';
Null:'null';
Iota:'iota';

Not:'not';
And:'and';
Or:'or';
For:'for';
If:'if';
Else: 'else';
While:'while';
Switch:'switch';
Case:'case';
Break: 'break' ';';
Continue: 'continue'';';

Integer : DIGIT+;
Float: DIGIT+ '.' DIGIT+;
DIGIT: [0-9];
Scientific: (Float|Integer) E ('-'|'+'|)Integer;
Letter: [a-zA-Z$_];
Identifier: Letter (Letter|DIGIT)+;
//Identifier:( Letter(Letter|Integer|Function|Import|Class|Int|Floatt|Bool|True|False|Null)+) | ((Letter|Integer|Function|Import|Class|Int|Floatt|Bool|True|False|Null)+Letter);

WS : [ \t\r\n]+ -> skip ;

COMMENT
    : '/*' .*? '*/' -> channel(2)
    ;

LINE_COMMENT
    : '///' ~[\r\n]* -> channel(2)
    ;