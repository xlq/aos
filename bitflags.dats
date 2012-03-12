staload "bitflags.sats"

extern prfun conjure_bit_is_set {x, n: int; b: bool} ():
  [bit_is_set (x, n) == b] void

implement test_bit {x} {n} (x, n) =
let
  prval pf_mask = SHL_make {1, n} ()
  prval () = SHL_le (pf_mask, ,(pf_shl_const 1 (INT_BIT-1)))
  val mask = ushl (pf_mask | 1u, n)
in
  if (x land mask) != 0u then
    let prval () = conjure_bit_is_set {x, n, true} () in true end
  else
    let prval () = conjure_bit_is_set {x, n, false} () in false end
end
