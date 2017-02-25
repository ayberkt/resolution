open Transform

module Naive : TRANSFORM = struct
  open List
  open AbsResolution

  let rec transform = function
    | Neg Neg p -> transform p
    | Neg Conj (p, q) -> Disj (transform (Neg p), transform (Neg q))
    | Neg Disj (p, q) -> Conj (transform (Neg p), transform (Neg q))
    | Disj (p, Conj (q, r)) ->
        Conj (transform (Disj (p, q)), transform (Disj (p, r)))
    | Disj (Conj (p, q), r) ->
        Conj (transform (Disj (p, r)), transform (Disj (q, r)))
    | Neg p -> Neg (transform p)
    | Disj (p, q) -> Disj (transform p, transform q)
    | Conj (p, q) -> Conj (transform p, transform q)
    | Prop _ as p -> p

  (* let rec omit_double_neg = function
    | Neg Neg p -> omit_double_neg p
    | Conj (p, q) -> Conj (omit_double_neg p, omit_double_neg q)
    | Disj (p, q) -> Disj (omit_double_neg p, omit_double_neg q)
    | Neg p -> Neg (omit_double_neg p)
    | Prop _ as p -> p
 *)
  (* let rec transform p = transform (transform p) *)

end
