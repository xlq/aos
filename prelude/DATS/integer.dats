implement SHL_make {x, n} () =
let
  prval [expn: int] pf_exp = EXP2_istot {n} ()
  prval pf_mul = mul_istot {x, expn} ()
  prval () = mul_nat_nat_nat pf_mul
  prval () = EXP2_ispos pf_exp
in
  (pf_exp, pf_mul)
end
