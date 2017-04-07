module Resolution = struct
  open AbsResolution
  open CNF.CNF
  open Core_kernel.Fn
  module CL = Core_kernel.Core_list
  module CA = Core_kernel.Core_array

  let printf = Core_kernel.Core_printf.printf

  let lit_compare l1 l2 =
    match (l1, l2) with
    | (Affirmative p, Affirmative q) -> String.compare p q
    | (Negative p, Negative q) -> String.compare p q
    | (Affirmative _, Negative _) -> 1
    | (Negative _, Affirmative _) -> -1

  let rec nub =
    function
    | [] -> []
    | x::xs -> x::nub (CL.filter ~f:(fun y -> not (x = y)) xs)

  let rec nub_cnf = CL.map ~f:(fun ys -> CL.map ~f:nub ys)

  let intersect p q =
    CL.filter ~f:(fun x -> CL.exists ~f:(fun k -> k = x) q) p

  let complement = function
    | Affirmative p -> Negative p
    | Negative p -> Affirmative p

  let bin_resolve p q =
    let conflicts = intersect (CL.map ~f:complement p) q in
    let conflicts = CL.append conflicts (CL.map ~f:complement conflicts) in
    let union = nub (CL.append p q) in
    let res =
      CL.filter ~f:(fun k -> CL.exists ~f:(fun x -> x = k) conflicts) union in
    let _  = printf "Conflicts: %s\n" (show_clause conflicts) in
    let _  = printf "Resolve %s with %s to get %s\n"
      (show_clause p) (show_clause q) (show_clause res) in
    res

  let rec refute_aux l l' =
    match l' with
    | [] -> false
    | x::xs ->
        let new_clauses = CL.map ~f:(fun y -> bin_resolve x y) l in
          if CL.exists ~f:CL.is_empty new_clauses
          then true
          else refute_aux (CL.append l new_clauses) xs

  let refute l = refute_aux l l

  let resolve = refute

end
