module CNF = struct
  module CS = Core_kernel.Core_string
  module CL = Core_kernel.Core_list
  type literal = Affirmative of string | Negative of string
  type clause  = literal CL.t
  type formCNF = clause CL.t

  let show_literal = function
    | Affirmative x -> x
    | Negative x -> "~" ^ x

  let show_clause p =
    match p with
    | [ x ] -> show_literal x
    | _ -> begin
      let pr s = "(" ^ s ^ ")" in
      pr (CS.concat (CL.intersperse ~sep:" \\/ " (CL.map ~f:show_literal p)))
    end

  let showCNF (p : formCNF) : string =
    CS.concat (CL.intersperse ~sep:" /\\ " (CL.map ~f:show_clause p))

end
