module type TRANSFORM = sig
  open AbsResolution
  open CNF.CNF
  val transform : form -> formCNF
end
