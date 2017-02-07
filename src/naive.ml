open Transform

module Naive : TRANSFORM = struct
  open List
  open AbsResolution

  let rec transform = function
    | Neg Neg phi -> phi
    | Neg Disj (p, q) -> Conj (Neg p, Neg q)
    | Neg Conj (p, q) -> Disj (Neg p, Neg q)
    | Disj (p , Conj (q, r)) -> Conj (Disj (p, q), Disj (p,r ))
    | Conj (p, Disj (q, r)) -> Disj (Conj (p, q), Conj (p, r))
    | x -> x

end
