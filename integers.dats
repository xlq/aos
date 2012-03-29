staload "integers.sats"
(*

implement test_mul_uint32_will_fit {a, b} (a, b) =
  if b = 0 then
    (Some_p (mul_uint32_0 ()) | true)
  else
    let
      val divr = uint32_of_int (UINT32_LIM-1) / b
      prval pf_divr = div_istot {a,b} ()
    in
      if divr < a then
        (Some_p (mul_uint32_div (pf_divr)) | true)
      else
        (None_p () | false)
    end
        
*)
