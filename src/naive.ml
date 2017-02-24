open Transform

module Naive : TRANSFORM = struct
  open List
  open AbsResolution

  let rec distribute = function
    | Disj (p, Conj (q, r)) ->
        let phi   = distribute (Disj (p, q)) in
        let theta = distribute (Disj (p, r)) in
        Conj (phi, theta)
    | Disj (Conj (p, q), r) ->
        let phi   = distribute (Disj (p, r)) in
        let theta = distribute (Disj (q, r)) in
        Conj (phi, theta)
    | Disj (p, q) -> Disj (distribute p, distribute q)
    | Conj (p, q) -> Conj (distribute p, distribute q)
    | Neg p -> Neg (distribute p)
    | Prop _ as p -> p

  let rec push_neg = function
    | Neg Conj (p, q) -> Disj (push_neg (Neg p), push_neg (Neg q))
    | Neg Disj (p, q) -> Conj (push_neg (Neg p), push_neg (Neg q))
    | Conj (p, q) -> Conj (push_neg p, push_neg q)
    | Disj (p, q) -> Disj (push_neg p, push_neg q)
    | Neg _ as p -> p
    | Prop _ as p -> p

  let rec omit_double_neg = function
    | Neg (Neg p) -> omit_double_neg p
    | Conj (p, q) -> Conj (omit_double_neg p, omit_double_neg q)
    | Disj (p, q) -> Disj (omit_double_neg p, omit_double_neg q)
    | Neg p -> Neg (omit_double_neg p)
    | Prop _ as p -> p

  let rec transform p = omit_double_neg p |> push_neg |> distribute

end
