staload "prelude/limits.sats"

// Encapsulate the property of a bit in an integer being set.

stacst bit_is_set : (int, int) -> bool

fun test_bit {x: Uint} {n: Nat | n < INT_BIT}
  (x: uint x, n: int n):
  bool (bit_is_set (x, n))

