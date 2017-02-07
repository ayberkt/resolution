module type TRANSFORM = sig
  open AbsResolution
  val transform : form -> form
end
