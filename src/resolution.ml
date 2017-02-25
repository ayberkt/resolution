module Resolution = struct
  open Array
  open AbsResolution

  type literal = Positive of string | Negative of string

  let lit_compare l1 l2 =
    let get_id = function Positive p -> p | Negative p -> p in
    String.compare (get_id l1) (get_id l1)

  module Clause =
    Set.Make (struct type t = literal let compare = lit_compare end)

  open Clause

  type clause = Clause.t
  type cnf_exp = clause array

  type result = Refuted | Resolution of clause

  let rec get_lit_set : form -> clause = function
    | Prop p -> singleton (Positive p)
    | Neg Prop p -> singleton (Negative p)
    | Disj (p, q) -> union (get_lit_set p) (get_lit_set q)
    | _ -> failwith "this must not have happened"

  let rec get_clauses : form -> cnf_exp = function
    | Conj (p, q) -> append (get_clauses p) (get_clauses q)
    | p -> Array.make 1 (get_lit_set p)

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

  let resolve_all cs =
    let clauses : clause array = Array.of_list cs
    in failwith "foo"

end
