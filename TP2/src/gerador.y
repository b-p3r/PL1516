
Program : Declarations Body 
;
Body : 'BEGIN' InstructionList 'END'
;
Declaration : id
| id '[' num ']'
| id '[' num ']' '[' num ']' 
;
Declarations : 'VAR' DeclarationsList ';' 
;
DeclarationsList : Declaration 
| DeclarationsList ',' Declaration 
;
Term : id
| num
| id '[' ExpAdditiv ']'
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']'
| '(' Exp ')'
| 'NOT' Exp
;
Variable : id
| id '[' ExpAdditiv ']'
| id '[' ExpAdditiv ']' '[' ExpAdditiv ']' 
;
ExMultipl : Term
| ExMultipl '*'  Term
| ExMultipl '/' Term
| ExMultipl '%' Term
| ExMultipl 'AND' Term
;
ExpAdditiv : ExMultipl 
| ExpAdditiv '+' ExMultipl
| ExpAdditiv '-' ExMultipl 
| ExpAdditiv 'OR' ExMultipl 
;

Exp : ExpAdditiv             
| '(' ExpAdditiv '>'  ExpAdditiv ')'
| '(' ExpAdditiv '<'  ExpAdditiv ')'
| '(' ExpAdditiv '>''=' ExpAdditiv ')'
| '(' ExpAdditiv '<''=' ExpAdditiv ')'
| '(' ExpAdditiv '=''=' ExpAdditiv ')'
| '(' ExpAdditiv '!''=' ExpAdditiv ')'
;


Atribution :  Variable '=' ExpAdditiv 
;
Instruction : Atribution ';' 
| 'READ'  Variable ';'
| 'WRITE' ExpAdditiv ';'                      
| 'WRITE' string ';'
| 'IF' '(' Exp ')' '{' InstructionsList '}' 
| 'IF' '(' Exp ')' '{' InstructionsList '}' 'ELSE' '{' InstructionsList '}' 
| 'WHILE '(' Exp ')' '{' InstructionsList '}' 
| 'DO''{' InstructionsList '}''WHILE '(' Exp ')' ';' 

InstructionList : Instruction
| InstructionList Instruction  
;
