module Nameless = struct
  open List
  open AbsResolution

  let vars = ref []

  type result = NotSeen | Index of int

  let seen x =
    let rec seen' i = function
      | [] -> NotSeen
      | (v::vs) when v = x -> Index i
      | (_::vs) -> seen' (i+1) vs
    in seen' 0 !vars

  let rec rm_names' xs = function
    | PropName (Ident x) -> begin
        match seen x with
        | NotSeen ->
            let i = length !vars in
              vars := (List.append !vars [x]); Prop i
        | Index i -> Prop i
      end
    | ConjExp (phi, theta) -> Conj (rm_names' xs phi, rm_names' xs theta)
    | DisjExp (phi, theta) -> Disj (rm_names' xs phi, rm_names' xs theta)
    | NegExp phi -> Neg (rm_names' xs phi)

  let rm_names phi = let r = rm_names' [] phi in vars := []; r

end
