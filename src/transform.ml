module Transform = struct
  open List
  open AbsResolution

  let rec subforms = function
    | Prop i -> []
    | Conj (alpha, beta) as phi ->
        phi::(append (subforms alpha) (subforms beta))
    | Disj (alpha, beta) as phi ->
        phi::(append (subforms alpha) (subforms beta))

end
