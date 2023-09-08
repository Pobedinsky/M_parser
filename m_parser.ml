open Misc

type function_t = Function.function_t = 
| Var of float
| E 
| PI
| X
| Log  of function_t * function_t
| Pow  of function_t * function_t
| Mult of function_t * function_t
| Sum  of function_t * function_t
| Div  of function_t * function_t;;


let rec string_of_function = function
| Var (f)    -> string_of_float(f)
| E          -> "e"
| PI         -> "π"
| X          -> "X"
| Pow (X, Var(g)) -> "X^("^ string_of_float g  ^ ")"
| Pow(X, f) when f = E || f = PI -> "X^"^ string_of_function f
| Pow (X, g) -> "X^("^ string_of_function g ^ ")"
| Pow (f, Var(g)) -> "("^ string_of_function f ^ ")^"^ string_of_float g
| Pow (f, g) -> "("  ^ string_of_function f ^ ")^("^ string_of_function g ^ ")"
| Mult (f, g)-> "("  ^ string_of_function f ^ ")*("^ string_of_function g ^ ")"
| Div (f, g) -> "("  ^ string_of_function f ^ ")/("^ string_of_function g ^ ")"
| Sum (f, g) -> "("  ^ string_of_function f ^ ")+("^ string_of_function g ^ ")"
| Log (f, g) -> "(Log ("  ^ string_of_function f ^ ") (" ^ string_of_function g ^ "))";;


let parse filename = 
  let oc = if filename = "stdin" then stdin else open_in filename in
  let lexbuf = Lexing.from_channel oc in
  let _ = init_pos lexbuf filename in
  try 
    let fl = Parser.main Lexer.token lexbuf in
    Some fl
  with 
  | LError msg -> print_lex_error msg;
      None
  | SError pos -> print_syntax_error pos;
      None
      
