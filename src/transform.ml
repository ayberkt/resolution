module Transform = struct
  open List
  open AbsResolution

  let rec subforms = function
    | Prop i -> []
    | Conj (alpha, beta) as phi ->
        phi::(append (subforms alpha) (subforms beta))
    | Disj (alpha, beta) as phi ->
        phi::(append (subforms alpha) (subforms beta))
    | Neg alpha as phi -> phi::subforms alpha

  let rec max = function
    | Prop i -> i
    | Neg alpha -> max alpha
    | Conj (alpha, beta) | Disj (alpha, beta) when max alpha > max beta ->
        max alpha
    | Conj (alpha, beta) | Disj (alpha, beta) -> max beta

  let (=>) p q = Disj (Neg p, q)

  let (<=>) p q = Conj (p => q, q => p)

  (* let rec new_vars = function *)
      (* | Prop i -> [] *)
      (* | Conj (alpha, beta) -> *)
          (* let nvars_alpha = new_vars alpha in *)
        (* let nvars_beta  = new_vars beta in *)
end
