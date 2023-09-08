open Lexing

exception
  LError of string

exception SError of Lexing.position

let pp_position pos = 
  "file :" ^ pos.pos_fname ^ ", line : " ^ string_of_int pos.pos_lnum
  ^ ", column : " ^ string_of_int (pos.pos_cnum - pos.pos_bol)

let lex_error lexbuf st =
  let pos = lexeme_start_p lexbuf in
  let msg = "Lexical Error in "^ pp_position pos ^ "\n\tthe characters \"" ^ st ^ "\"are not valid\n"
  in raise (LError msg)

let print_lex_error msg = Printf.fprintf stderr "%s\n%!" msg;;

let print_syntax_error pos =
  Printf.fprintf stderr "Syntex Error in %s\n!" (pp_position pos);;

let fname =
  if Array.length Sys.argv = 2 && Sys.file_exists Sys.argv.(1) then Sys.argv.(1) else "stdin";;

let init_pos lx f =
  let pos = lx.lex_curr_p in
  lx.lex_curr_p <-
    {pos with pos_fname = f; pos_lnum = 1; pos_bol = pos.pos_cnum}
