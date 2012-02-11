staload "enablable.sats"

implement {vt:viewt@ype} empty () =
let
  var x: vt?
  prval () = opt_none {vt} x
in
  @{enabled = false, obj = x}: enablable vt
end
