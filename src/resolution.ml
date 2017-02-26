module Resolution = struct
  open AbsResolution
  open Core_kernel.Fn
  module CL = Core_kernel.Core_list
  module CA = Core_kernel.Core_array

  let printf = Core_kernel.Core_printf.printf

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
    match f with
    | Prop p -> singleton (Positive p)
    | Neg Prop p -> singleton (Negative p)
    | Disj (p, q) -> union (get_lit_set p) (get_lit_set q)
    | _ -> failwith "this must not have happened"


  let show_clause = function
    | None -> ""
    | Some c ->
        let proj = function
          | Positive p -> p
          | Negative p -> "~" ^ p
        in
        let ss = Clause.elements c in
        "{" ^ (String.concat ", " (List.map proj ss)) ^ "}"

  let print_clause (c : clause option) = Printf.printf "%s\n" (show_clause c)

  let get_clauses cs =
    let seen : (clause list) ref = ref [] in
    let rec get_clauses' = function
      | Conj (p, q) -> CA.append (get_clauses' p) (get_clauses' q)
      | p ->
        let p' = get_lit_set p in
        if List.mem p' !seen
        then Array.make 0 p'
        else (seen := p'::!seen; CA.create 1 p')
    in
      get_clauses' cs

  let complement = function Positive p -> Negative p | Negative p -> Positive p

  let is_trivial c = exists (fun x -> Clause.mem (complement x) c) c

  let omit_trivials (xs : clause array) : clause array =
    let p = function
      | c when non is_trivial c -> true
      | c ->
        (printf "Omitting trivial clause: %s\n" (show_clause (Some c))); false
    in
      CA.filter p xs

  let neg_clause = Clause.map complement

  let resolve (c1 : clause) (c2 : clause) : clause =
    let neg_c1 = neg_clause c1 in
    let confs = inter neg_c1 c2 in
      if is_empty confs
      then empty
      else diff (union c1 c2) (union confs (neg_clause confs))

  exception Found


  let resolve_all (cs : clause array) =
    let clauses = CA.map (fun x -> if is_trivial x then None else Some x) cs in
    let print_clauses () =
      Printf.printf "Clauses: [ ";
      CA.iter clauses (fun x -> Printf.printf "%s " (show_clause x));
      Printf.printf "]\n"
    in
    print_clauses ();
    let find_reso_bin i c1' j (c2' : clause option) =
      print_clauses ();
      match (c1', c2') with
      | (Some c1, Some c2) when c1 = c2 -> false
      | (Some c1, Some c2) ->
          let r : clause = resolve c1 c2 in
          Printf.printf "Resolving %s with %s to get %s.\n"
          (show_clause c1') (show_clause c2') (show_clause (Some r));
            if is_empty r
            then true
            else (
              clauses.(i) <- Some r;
              clauses.(j) <- None;
              print_clauses ();
              false
            )
      | _ -> false in
  let rec existsi p =
    let f x i = if p x i then raise Found else () in
      try CA.iteri f clauses; false with Found -> true in
  let rec find_reso_bin_all i c = existsi (find_reso_bin i c) in
    if existsi find_reso_bin_all then Refuted else Valid
end
