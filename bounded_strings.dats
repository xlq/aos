staload "bounded_strings.sats"

assume bstring (l: addr, sz: int, len: int) =
  [len < sz]
  @{
    pf = @[char][sz] @ l,
    s = ptr l,
    len = int len,
    sz = int sz
  }

(*
implement create (s, pf, buf, sz) =
  s := @{ pf = pf, s = buf, len = 0, sz = sz }
*)

implement create (pf | buf, sz) =
  @{ pf=pf, s=buf, len=0, sz=sz }

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

viewdef stream_v (l: addr, sz: int, p: addr) =
  [len: nat | len < sz] bstring (l, sz, len) @ p

assume stream_vt (l: addr, sz: int, p: addr) =
  @{pf = stream_v (l, sz, p), p = ptr p}

var funcs: {l: agz; sz: Nat; p: agz}
  $Streams.funcs (stream_vt (l, sz, p)) =
  @{
    put_char = put_char
  }
where {
  fn put_char {l: agz; sz: Nat; p: agz}
    (obj: !stream_vt (l, sz, p), ch: char):<> void =
  let prval pf = obj.pf: stream_v (l, sz, p) in
    if obj.p->len < obj.p->sz - 1 then
      append_char (!(obj.p), ch);
    let prval () = obj.pf := pf in () end
  end
}

val (pf_funcs | ()) = vbox_make_view_ptr (view@ funcs | &funcs)

implement stream {p, l, sz, len} (pf | p) =
  @{
    p = @{pf=pf, p=p},
    pf_funcs = pf_funcs,
    //vbox_unsafe_copy
    //  {$Streams.funcs (stream_vt (l, sz, p))} pf_funcs,
    funcs = &funcs
  }

implement unstream {p, l, sz} (stream) = stream.p.pf
