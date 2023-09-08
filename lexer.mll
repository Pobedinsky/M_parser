{
open Parser
}

let digit = ['0' - '9']
let num = '-'? ['0' - '9']+ ('.' digit*)?
let float_literal = '-'? digit* ('.' digit+)?


rule token = parse
  | [' ' '\t' '\r' '\n']   { token lexbuf }
  | "Log"                  { LOG }
  | "^"                    { POW }
  | "*"                    { MULT }
  | "+"                    { SUM }
  | "/"                    { DIV }
  | float_literal as k     { VAR(float_of_string k) }
  | "e" | "E"              { E }
  | "pi" | "PI"            { PI }
  | "X" | "x"              { X }
  | eof                    { EOF }
