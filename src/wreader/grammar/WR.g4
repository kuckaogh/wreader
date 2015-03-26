
grammar WR;
@header {

import java.util.Map;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
}

module: networks? EOF;

networks : network+ ;

network : Net ID '{' line+ '}';

line : In? (ID | link) Out? ;

link : (group Arr)+ group ;

group : ID (',' ID)* ;

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

number :  
        ( INT | FLOAT )
       ;

LINE_COMMENT
    :   '!' ~[\r\n]* -> skip
    ;

// Keywords
Net: 'net' ;
In : '*>>' ;
Out : '>>*' ;
Arr : '>>' ;

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


