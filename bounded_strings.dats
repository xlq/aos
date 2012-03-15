staload "bounded_strings.sats"

assume bstring (l: addr, sz: int, len: int) =
  [len < sz]
  @{
    pf = (@[char][sz]) @ l,
    s = ptr l,
    len = int len
  }

implement create (s, pf, buf) =
  s := @{ pf = pf, s = buf, len = 0 }

implement destroy (s) =
  (s.pf | ())

implement length (s) = s.len

implement clear (s) = s.len := 0

implement char_at (s, idx) =
let
  prval pf = s.pf
  val ch = s.s->[idx]
  prval () = s.pf := pf
in ch end

implement set_char_at (s, idx, ch) =
let
  prval pf = s.pf
  val () = s.s->[idx] := ch
  prval () = s.pf := pf
in () end

implement append_char (s, ch) =
let
  prval pf = s.pf
  val () = s.s->[s.len] := ch
  prval () = s.pf := pf
  val () = s.len := s.len + 1
in () end

implement append_string {l, sz, len, len2} (s, s2, len2) =
let var i: Int in
  for* {i: nat | i <= len2} .<len2-i>. (i: int i) =>
  (i := 0; i < len2; i := i + 1)
    let prval pf = s.pf in
      s.s->[s.len + i] := s2[i];
      let prval () = s.pf := pf in () end
    end;
  s.len := s.len + len2
end

implement append_bstring {l, sz, len, l2, sz2, len2} (s, s2) =
let var i: Int in
  for* {i: nat | i <= len2} .<len2-i>. (i: int i) =>
  (i := 0; i < s2.len; i := i + 1)
    let prval pf = s.pf in
      s.s->[s.len + i] := s2[i];
      let prval () = s.pf := pf in () end
    end;
  s.len := s.len + s2.len
end


