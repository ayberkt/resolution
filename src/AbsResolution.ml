(* OCaml module generated by the BNF converter *)


type ident = Ident of string
and formExp =
   PropName of ident
 | NegExp of formExp
 | DisjExp of formExp * formExp
 | ConjExp of formExp * formExp
 | ImplExp of formExp * formExp

and form =
   Conj of form * form
 | Disj of form * form
 | Prop of string
 | Neg of form
