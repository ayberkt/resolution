(* OCaml module generated by the BNF converter *)


type ident = Ident of string
and formExp =
   PropName of ident
 | ConjExp of formExp * formExp
 | DisjExp of formExp * formExp

and form =
   Conj of form * form
 | Disj of form * form
 | Prop of int

