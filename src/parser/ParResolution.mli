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

val pFormExp :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> AbsResolution.formExp
