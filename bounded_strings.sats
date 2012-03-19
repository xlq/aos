// Bounded-length strings: strings in fixed-length buffers.
// Note that the buffer must be at least one byte long, for
// the null terminator.

staload "prelude/limits.sats"
staload Streams = "streams.sats"

absviewt@ype bstring (l: addr, sz: int, len: int) = @( ptr, int )

(*
fun create {l: agz} {sz: Pos}
  (s: &bstring (l, sz, 0)? >> bstring (l, sz, 0),
   pf: (@[char][sz]) @ l,
   buf: ptr l,
   sz: int sz):<> void
*)

fun create {l: agz} {sz: Pos}
  (pf: @[char][sz] @ l |
   buf: ptr l, sz: int sz):<>
  bstring (l, sz, 0)

fun destroy {l: agz} {sz: Nat} {len: int}
  (s: &bstring (l, sz, len) >> bstring (l, sz, len)?):<>
  (@[char][sz] @ l | void)

fun length {l: agz; sz: Nat; len: nat}
  (s: &bstring (l, sz, len)):<> int len

fun clear {l: agz; sz: Nat; len: nat}
  (s: &bstring (l, sz, len) >> bstring (l, sz, 0)):<> void

fun char_at {l: agz; sz: Nat; len, idx: nat | idx < len}
  (s: &bstring (l, sz, len), idx: int idx):<> char
overload [] with char_at

fun set_char_at {l: agz; sz: Nat; len, idx: nat | idx < len}
  (s: &bstring (l, sz, len), idx: int idx, ch: char):<> void
overload [] with set_char_at

fun append_char {l: agz} {sz: Nat} {len: nat | len < sz-1}
  (s: &bstring (l, sz, len) >> bstring (l, sz, len+1),
   ch: char):<> void

fun append_string
  {l: agz; sz: Nat; len: nat | len < sz;
   len2: nat | len + len2 < sz}
  (s: &bstring (l, sz, len) >> bstring (l, sz, len+len2),
   s2: string len2,
   len2: int len2):<> void

fun append_bstring
  {l: agz; sz: Nat; len: nat | len < sz;
   l2: agz; sz2: Nat; len2: nat | len + len2 < sz}
  (s: &bstring (l, sz, len) >> bstring (l, sz, len+len2),
   s2: &bstring (l2, sz2, len2)):<> void

absviewtype stream_vt (l: addr, sz: int, p: addr)

fun stream
  {p, l: agz; sz: Nat; len: nat | len < sz}
  (pf: bstring (l, sz, len) @ p | p: ptr p):<>
  $Streams.stream (stream_vt (l, sz, p))

prfun unstream
  {p, l: agz; sz: Nat}
  (stream: $Streams.stream (stream_vt (l, sz, p))):<>
  [len: nat | len < sz] bstring (l, sz, len) @ p
