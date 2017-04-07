open Transform

module Naive : TRANSFORM = struct
  open List
  open AbsResolution
  module CL = Core_kernel.Core_list
  open CNF.CNF

  let dist l l' =
    List.concat (List.map (fun e -> List.map (fun e' -> CL.append e e') l') l)

  let rec transform : form -> formCNF = function
    | Prop p -> [[Affirmative p]]
    | Conj (p, q) -> CL.append (transform p) (transform q)
    | Disj (p, q) -> dist (transform p) (transform q)
    | Neg p -> begin
        match p with
        | Prop x -> [[Negative x]]
        | Neg q -> transform q
        | Conj (p, q) -> transform (Disj (Neg p, Neg q))
        | Disj (p, q) -> transform (Conj (Neg p, Neg q))
      end

end
