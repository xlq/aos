staload "prelude/limits.sats"

typedef funcs (VT: viewtype) =
  @{
    put_char = (!VT, char) -<fun> void
  }

viewtypedef stream (VT: viewtype) =
  [lfuncs: agz]
  @{
    p = VT,
    pf_funcs = vbox (funcs VT @ lfuncs),
    funcs = ptr lfuncs
  }

fun put_char {ST: viewtype}
  (stream: &stream ST, ch: char):<!ref> void

symintr put

fun put_string1 {ST: viewtype} {len: Nat}
  (stream: &stream ST, item: string len, len: int len):<!ref> void
overload put with put_string1

fun put_string {ST: viewtype}
  (stream: &stream ST, item: string):<!ref> void
overload put with put_string

dataprop Hex = HEX
fun put_nat_hex {ST: viewtype}
  (_: Hex | stream: &stream ST, item: Nat):<!ref> void
overload put with put_nat_hex
