staload "streams.sats"

implement put_char (stream, ch) =
let val f = stream.funcs->put_char where
      { prval vbox pf_funcs = stream.pf_funcs }
in () end

implement put_string1 {ST} {len} (stream, item, len) =
let var i: Int in
  for* {i: nat | i <= len} .<len-i>. (i: int i) =>
  (i := 0; i < len; i := i + 1)
    put_char (stream, item[i])
end

implement put_string (stream, item) =
let
  val s = string1_of_string item
  val len = string_length s
in
  put (stream, s, len)
end

implement put_nat_hex {ST} (_ | stream, x) =
let
  val x = uint1_of x
in
  if x > 0u then
    let
      val q = x / 16u
      val r = x mod 16u
      val chars: string 16 = "0123456789ABCDEF"
    in
      put_nat_hex {ST} (HEX | stream, int1_of q);
      put_char (stream, chars[int1_of r])
    end
end
