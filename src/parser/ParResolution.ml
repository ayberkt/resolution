type token =
  | SYMB1
  | SYMB2
  | SYMB3
  | SYMB4
  | TOK_EOF
  | TOK_Ident of (string)
  | TOK_String of (string)
  | TOK_Integer of (int)
  | TOK_Double of (float)
  | TOK_Char of (char)

open Parsing;;
let _ = parse_error;;
# 3 "src/parser/ParResolution.mly"
open AbsResolution
open Lexing


# 21 "src/parser/ParResolution.ml"
let yytransl_const = [|
  257 (* SYMB1 *);
  258 (* SYMB2 *);
  259 (* SYMB3 *);
  260 (* SYMB4 *);
  261 (* TOK_EOF *);
    0|]

let yytransl_block = [|
  262 (* TOK_Ident *);
  263 (* TOK_String *);
  264 (* TOK_Integer *);
  265 (* TOK_Double *);
  266 (* TOK_Char *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\003\000\003\000\005\000\005\000\002\000\002\000\
\006\000\004\000\007\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\003\000\003\000\001\000\003\000\001\000\
\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\000\000\010\000\012\000\000\000\006\000\
\003\000\000\000\008\000\000\000\000\000\001\000\000\000\004\000\
\000\000\005\000"

let yydgoto = "\002\000\
\006\000\007\000\008\000\009\000\010\000\011\000\000\000"

let yysindex = "\001\000\
\000\255\000\000\000\000\254\254\000\000\000\000\008\255\000\000\
\000\000\014\255\000\000\012\255\254\254\000\000\254\254\000\000\
\014\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\003\255\000\000\000\000\000\000\000\000\000\000\000\000\
\007\255\000\000"

let yygindex = "\000\000\
\000\000\013\000\003\000\000\000\006\000\000\000\000\000"

let yytablesize = 19
let yytable = "\003\000\
\004\000\001\000\004\000\005\000\009\000\005\000\009\000\009\000\
\007\000\013\000\007\000\007\000\014\000\013\000\015\000\016\000\
\012\000\018\000\017\000"

let yycheck = "\000\001\
\003\001\001\000\003\001\006\001\002\001\006\001\004\001\005\001\
\002\001\002\001\004\001\005\001\005\001\002\001\001\001\004\001\
\004\000\015\000\013\000"

let yynames_const = "\
  SYMB1\000\
  SYMB2\000\
  SYMB3\000\
  SYMB4\000\
  TOK_EOF\000\
  "

let yynames_block = "\
  TOK_Ident\000\
  TOK_String\000\
  TOK_Integer\000\
  TOK_Double\000\
  TOK_Char\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'formExp) in
    Obj.repr(
# 28 "src/parser/ParResolution.mly"
                           ( _1 )
# 101 "src/parser/ParResolution.ml"
               : AbsResolution.formExp))
; (fun __caml_parser_env ->
    Obj.repr(
# 29 "src/parser/ParResolution.mly"
          ( raise (BNFC_Util.Parse_error (Parsing.symbol_start_pos (), Parsing.symbol_end_pos ())) )
# 107 "src/parser/ParResolution.ml"
               : AbsResolution.formExp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ident) in
    Obj.repr(
# 32 "src/parser/ParResolution.mly"
                 ( PropName _1 )
# 114 "src/parser/ParResolution.ml"
               : 'formExp3))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'formExp) in
    Obj.repr(
# 33 "src/parser/ParResolution.mly"
                        (  _2 )
# 121 "src/parser/ParResolution.ml"
               : 'formExp3))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'formExp2) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'formExp3) in
    Obj.repr(
# 36 "src/parser/ParResolution.mly"
                                   ( ConjExp (_1, _3) )
# 129 "src/parser/ParResolution.ml"
               : 'formExp2))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formExp3) in
    Obj.repr(
# 37 "src/parser/ParResolution.mly"
             (  _1 )
# 136 "src/parser/ParResolution.ml"
               : 'formExp2))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'formExp) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'formExp2) in
    Obj.repr(
# 40 "src/parser/ParResolution.mly"
                                 ( DisjExp (_1, _3) )
# 144 "src/parser/ParResolution.ml"
               : 'formExp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formExp1) in
    Obj.repr(
# 41 "src/parser/ParResolution.mly"
             (  _1 )
# 151 "src/parser/ParResolution.ml"
               : 'formExp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formExp2) in
    Obj.repr(
# 44 "src/parser/ParResolution.mly"
                    (  _1 )
# 158 "src/parser/ParResolution.ml"
               : 'formExp1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 49 "src/parser/ParResolution.mly"
                   ( Ident _1 )
# 165 "src/parser/ParResolution.ml"
               : 'ident))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 50 "src/parser/ParResolution.mly"
                    ( _1 )
# 172 "src/parser/ParResolution.ml"
               : 'int))
(* Entry pFormExp *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let pFormExp (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : AbsResolution.formExp)
