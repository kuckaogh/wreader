
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

study: seq model EOF;

seq: SEQ ID '{' MODEL ID ORDER INT '}' ;

model: MODEL ID '{' (define | goal | obj )+ '}' ;

obj : OBJECTIVE ID '=' '{' weight+ '}' ;

weight : '[' ID ',' number ']' ;

goal : GOAL ID '{' constraint '}' ;

define: dv | sv ;

sv : DEFINE ID '{' VALUE number '}';

dv: DEFINE ID '{' (LOWER dvbound)? (UPPER dvbound)? STD? KIND QUOTE UNITS QUOTE '}';

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

LINE_COMMENT
    :   '!' ~[\r\n]* -> skip
    ;


QUOTE : '\'' (Letter|Digit|'_'|'-')+ '\'' ;

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


