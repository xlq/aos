staload "prelude/limits.sats"

castfn uint8_of_uint {a: Uint8}
  (a: uint a):<> uint8

castfn uint_of_uint8
  (a: uint8): [r: Uint8] uint r
