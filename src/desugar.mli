module Desugar : sig
  open AbsResolution
  val desugar : formExp -> form
end
