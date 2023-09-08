%{
open Function
%}

%token LPAREN RPAREN E PI X LOG POW MULT SUM DIV EOF
%token <float> VAR

%start main
%type <Function.function_t> main

%%

main:
  | functiont EOF { $1 }

functiont:
  | LPAREN functiont RPAREN   { $2 }
  | LOG functiont functiont   { Log($2, $3) }
  | functiont POW functiont   { Pow($1, $3) }
  | functiont MULT functiont  { Mult($1, $3) }
  | functiont SUM functiont   { Sum($1, $3) }
  | functiont DIV functiont   { Div($1, $3) }
  | VAR                       { Var($1) }
  | E                         { E }
  | PI                        { PI }
  | X                         { X }
