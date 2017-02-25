module Resolution = struct
  open Array
  open AbsResolution

  type literal = Positive of string | Negative of string

  let lit_compare l1 l2 =
    match (l1, l2) with
    | (Positive p, Positive q) -> String.compare p q
    | (Negative p, Negative q) -> String.compare p q
    | (Positive _, Negative _) -> 1
    | (Negative _, Positive _) -> -1

  module Clause =
    Set.Make (struct type t = literal let compare = lit_compare end)

  open Clause

  type clause = Clause.t
  type cnf_exp = clause array

  type step = Box | Resolution of clause

  type result = Refuted | Valid

  let rec get_lit_set f =
    let _ = Printf.printf "get_lit_set\n" in
    match f with
    | Prop p -> singleton (Positive p)
    | Neg Prop p -> singleton (Negative p)
    | Disj (p, q) -> union (get_lit_set p) (get_lit_set q)
    | _ -> failwith "this must not have happened"


  let show_clause (c : clause) =
    let proj = function
      | Positive p -> p
      | Negative p -> "~" ^ p
    in
    let ss = Clause.elements c in
    "{" ^ (String.concat ", " (List.map proj ss)) ^ "}"

  let print_clause (c : clause) = Printf.printf "%s\n" (show_clause c)

  let get_clauses cs =
    let seen : (clause list) ref = ref [] in
    let rec get_clauses' = function
      | Conj (p, q) -> append (get_clauses' p) (get_clauses' q)
      | p ->
        let p' = get_lit_set p in
        if List.mem p' !seen
        then Array.make 0 p'
        else (seen := p'::!seen; Array.make 1 p')
    in
      get_clauses' cs

  let complement = function Positive p -> Negative p | Negative p -> Positive p

  let rec form_to_cnf = get_clauses

  let is_trivial c = exists (fun x -> Clause.mem (complement x) c) c

  let omit_trivials xs = List.filter (fun x -> not (is_trivial x)) xs

  let resolve c1 c2 =
    let neg_c1 = fold (fun x xs -> add (complement x) xs) empty c1 in
    let contradictions = inter neg_c1 c2 in
      if is_empty (inter neg_c1 c2)
      then empty
      else diff (union c1 c2) contradictions

  exception Found


  let resolve_all (cs : clause array) =
    let _ =
      Printf.printf "Clauses: ";
      Array.iter (fun x -> Printf.printf "%s\n" (show_clause x)) cs in
    let cs' = Array.map (fun x -> Some x) cs in
    let clauses : (clause option) array = cs' in
    let find_reso_bin i c1' j (c2' : clause option) =
      match (c1', c2') with
      | (Some c1, Some c2) ->
          let _ =
            Printf.printf "Comparing %s with %s.\n"
            (show_clause c1) (show_clause c2) in
          let r = resolve c1 c2 in
          if is_empty r
          then true
          else
            let _ = Array.set clauses i (Some r); Array.set clauses j None
            in false
      | _ -> false in
  let rec existsi p xs =
    let f x i = if p x i then raise Found else () in
    try
      Array.iteri f xs; false
    with
    | Found -> true in
  let rec find_reso_bin_all i c = existsi (find_reso_bin i c) clauses in
  if existsi find_reso_bin_all clauses then Refuted else Valid
end
