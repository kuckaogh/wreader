
grammar LW;
@header {

import java.util.Map;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
}
@member {
	
	
	
}

study: initial? seq+ (group|model)+ EOF;

initial: INITIAL '{' sv+ '}' ;

seq: SEQ ID '{' MODEL ID condition? ORDER INT '}' ;

model: MODEL ID '{' item+ '}' ;

group: GROUP ID '{' item+ '}' ;

include: INCLUDE ('[' LOCAL ']')? ( QUOTE | (GROUP ID) ) ;

item: define | goal | obj | include ;

obj : OBJECTIVE ID '=' '{' weight+ '}' ;

weight : '[' ID ',' number ']' ;

goal : GOAL ID '{' constraint '}' ;

define: dv | sv | alias ;

alias : DEFINE ID '{' ALIAS ID KIND QUOTE UNITS QUOTE '}' ;

sv : ( SVAR | DEFINE ) ID '{' VALUE number '}';

dv : DEFINE ID '{' (LOWER dvbound)? (UPPER dvbound)? STD? KIND QUOTE UNITS QUOTE '}';

condition : CONDITION logical;

logical : logical (OR|AND) logical 
		| expr ('>'|'<'|'=='|'>='|'<=') expr
        | '(' logical ')'   
		;

constraint : expr ('>'|'<'|'=') expr ; 

expr: ('-'|'+') expr
    |   expr ('*'|'/') expr
    |   expr ('+'|'-') expr
    |   '(' expr ')'
    |   ID
    |   INT
    |   FLOAT
    |   term {System.out.println("hello!\n");}
    ;

term : number ID ;

dvbound : number | UNBOUNDED ;

number :  
        ( INT | FLOAT )
       ;

MULTI_LINE_COMMENT : '/*' .*? '*/' -> skip ; 

LINE_COMMENT
    :   '!' ~[\r\n]* -> skip
    ;


QUOTE : '\'' (Letter|Digit|'_'|'-'|'.'|'\\')+ '\'' ;

// Keywords
OBJECTIVE : 'OBJECTIVE' | 'Objective' | 'objective' ;
GOAL : 'GOAL' | 'Goal' | 'goal' ;
VALUE : 'VALUE' | 'Value' | 'value' ;
STD : 'STD' | 'Std' | 'std' ;
UNBOUNDED : 'UNBOUNDED' | 'Unbounded' | 'unbounded' ;
LOWER : 'LOWER' | 'Lower' | 'lower' ;
UPPER : 'UPPER' | 'Upper' | 'upper' ;
KIND : 'KIND' | 'Kind' | 'kind' ;
UNITS : 'UNITS' | 'Units' | 'units' ;
SEQ : 'SEQUENCE' | 'Sequence' | 'sequence' ;
MODEL : 'MODEL' | 'Model' | 'model' ;
ORDER : 'ORDER' | 'Order' | 'order' ;
DEFINE : 'DEFINE' | 'Define' | 'define' ;
INITIAL : 'INITIAL' | 'Initial' | 'initial' ;
SVAR : 'SVAR' | 'Svar' | 'svar' ;
CONDITION : 'CONDITION' | 'Condition' | 'condition' ;
OR : '.OR.' | '.Or.' | '.or.' ;
AND: '.AND.' | '.And.' | '.and.';
GROUP : 'GROUP' | 'Group' | 'group' ;
INCLUDE : 'INCLUDE' | 'Include' | 'include' ;
ALIAS : 'ALIAS' | 'Alias' | 'alias' ;
LOCAL : 'LOCAL' | 'Local' | 'local' ;

//// Time
//MONTH:'MONTH'|'Month'|'month';
//JAN:'JAN';
//FEB:'FEB';
//MAR:'MAR';
//APR:'APR';
//MAY:'MAY';
//JUN:'JUN';
//JUL:'JUL';
//AUG:'AUG';
//SEP:'SEP';
//OCT:'OCT';
//NOV:'NOV';
//DEC:'DEC';

INT :   Digit+  ;

FLOAT:  Digit+ '.' Digit* 
    |   '.' Digit+
    ;


fragment Digit:  '0'..'9' ; 




ID  :   Letter (Letter|Digit|'_'|'.')*
    ;

fragment Letter  : [a-zA-Z] ;


WS  :  [ \t\r\n]+ -> skip
    ;


