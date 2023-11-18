%{
open Ast
%}

%token <int> INT
%token <float> FLOAT
%token <string> ID
%token TRUE
%token FALSE
%token LEQ
%token GEQ
%token TIMES
%token DIVIDE
%token PLUS
%token MINUS
%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token COLON
%token INT_TYPE
%token FLOAT_TYPE
%token BOOL_TYPE
%token EOF
%token FMULT 
%token FMINUS 
%token FPLUS
%token FDIVIDE

%nonassoc THEN ELSE
%left LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%left FPLUS FMINUS
%left FMULT FDIVIDE

%start <Ast.expr> prog

%%

prog:
	| e = expr; EOF { e }
	;
	
expr:
	| i = INT { Int i }
	| x = ID { Var x }
	| f = FLOAT { Float f }
  	| TRUE { Bool true }
  	| FALSE { Bool false }
  	| e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
	| e1 = expr; GEQ; e2 = expr { Binop (Geq, e1, e2) }
  	| e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2) }
	| e1 = expr; DIVIDE; e2 = expr { Binop (Divide, e1, e2) }
  	| e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }
	| e1 = expr; MINUS; e2 = expr { Binop (Sub, e1, e2) }
	| e1 = expr; FMINUS; e2 = expr { Binop (FSub, e1, e2) }
	| e1 = expr; FPLUS; e2 = expr { Binop (FAdd, e1, e2) }
	| e1 = expr; FMULT; e2 = expr { Binop (FMult, e1, e2) }
	| e1 = expr; FDIVIDE; e2 = expr { Binop (FDivide, e1, e2) }
  	| LET; x = ID; COLON; t = typ; EQUALS; e1 = expr; IN; e2 = expr 
		{ Let (x, t, e1, e2) }
  	| IF; e1 = expr; THEN; e2 = expr; ELSE; e3 = expr { If (e1, e2, e3) }
  	| LPAREN; e=expr; RPAREN {e}
	;

typ: 
	| INT_TYPE { TInt }
	| FLOAT_TYPE { TFloat }
	| BOOL_TYPE { TBool }
