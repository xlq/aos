staload "prelude/limits.sats"

(**********  CONVERSION  **********)

castfn int1_of_uint1 {x: Int} (x: uint x):<> int x
castfn uint1_of_int1 {x: Uint} (x: int x):<> uint x
castfn int1_of_int (x: int):<> [x':Int] int x'
castfn int_of_int1 {x: Int} (x: int x):<> int
castfn uint1_of_uint (x: uint):<> [x':Uint] uint x'
castfn uint_of_uint1 {x: Uint} (x: uint x):<> uint


overload int1_of with int1_of_uint1
overload uint1_of with uint1_of_int1
overload int1_of with int1_of_int
overload int_of with int_of_int1
overload uint1_of with uint1_of_uint
overload uint_of with uint_of_uint1

(**********  SIGNED, UNINDEXED  **********)

fun eq_int_int (a: int, b: int):<> bool = "mac#atspre_eq"
fun ne_int_int (a: int, b: int):<> bool = "mac#atspre_ne"
fun lt_int_int (a: int, b: int):<> bool = "mac#atspre_lt"
fun gt_int_int (a: int, b: int):<> bool = "mac#atspre_gt"
fun le_int_int (a: int, b: int):<> bool = "mac#atspre_le"
fun ge_int_int (a: int, b: int):<> bool = "mac#atspre_ge"
overload = with eq_int_int
overload != with ne_int_int
overload < with lt_int_int
overload > with gt_int_int
overload <= with le_int_int
overload >= with ge_int_int

(**********  SIGNED, INDEXED  **********)

fun eq_int1_int1
  {a, b: int} (a: int a, b: int b):<>
  bool (a == b) = "mac#atspre_eq"
fun ne_int1_int1
  {a, b: int} (a: int a, b: int b):<>
  bool (a <> b) = "mac#atspre_ne"
fun lt_int1_int1
  {a, b: int} (a: int a, b: int b):<>
  bool (a < b) = "mac#atspre_lt"
fun gt_int1_int1
  {a, b: int} (a: int a, b: int b):<>
  bool (a > b) = "mac#atspre_gt"
fun le_int1_int1
  {a, b: int} (a: int a, b: int b):<>
  bool (a <= b) = "mac#atspre_le"
fun ge_int1_int1
  {a, b: int} (a: int a, b: int b):<>
  bool (a >= b) = "mac#atspre_ge"
overload = with eq_int1_int1
overload != with ne_int1_int1
overload < with lt_int1_int1
overload > with gt_int1_int1
overload <= with le_int1_int1
overload >= with ge_int1_int1

fun add_int1_int1
  {a, b: int | a + b >= INT_MIN && a + b <= INT_MAX}
  (a: int a, b: int b):<> int (a + b)
  = "mac#atspre_add"
overload + with add_int1_int1

fun sub_int1_int1
  {a, b: int | a - b >= INT_MIN && a - b <= INT_MAX}
  (a: int a, b: int b):<> int (a - b)
  = "mac#atspre_sub"
overload - with sub_int1_int1

fun premul_int1_int1
  {a, b: int} (a: int a, b: int b):<>
  bool (a * b >= INT_MIN && a * b <= INT_MAX)
  = "atspre_premul_int1_int1"
overload *? with premul_int1_int1

fun mul_int1_int1
  {a, b: int | a * b >= INT_MIN && a * b <= INT_MAX}
  (a: int a, b: int b):<> int (a * b)
  = "mac#atspre_mul"
overload * with mul_int1_int1

fun imul2
  {a, b: int | a * b >= INT_MIN && a * b <= INT_MAX}
  (a: int a, b: int b):<> [r: Int] (MUL(a,b,r) | int r)
  = "mac#atspre_mul"

(**********  UNSIGNED, UNINDEXED  **********)

fun eq_uint_uint (a: uint, b: uint):<> bool = "mac#atspre_eq"
fun ne_uint_uint (a: uint, b: uint):<> bool = "mac#atspre_ne"
fun lt_uint_uint (a: uint, b: uint):<> bool = "mac#atspre_lt"
fun gt_uint_uint (a: uint, b: uint):<> bool = "mac#atspre_gt"
fun le_uint_uint (a: uint, b: uint):<> bool = "mac#atspre_le"
fun ge_uint_uint (a: uint, b: uint):<> bool = "mac#atspre_ge"
fun land_uint_uint (a: uint, b: uint):<> uint = "mac#atspre_land"
fun lor_uint_uint (a: uint, b: uint):<> uint = "mac#atspre_lor"
overload = with eq_uint_uint
overload != with ne_uint_uint
overload < with lt_uint_uint
overload > with gt_uint_uint
overload <= with le_uint_uint
overload >= with ge_uint_uint
overload land with land_uint_uint
overload lor with lor_uint_uint

(**********  UNSIGNED, INDEXED  **********)

fun eq_uint1_uint1
  {a, b: int} (a: uint a, b: uint b):<>
  bool (a == b) = "mac#atspre_eq"
fun ne_uint1_uint1
  {a, b: int} (a: uint a, b: uint b):<>
  bool (a <> b) = "mac#atspre_ne"
fun lt_uint1_uint1
  {a, b: int} (a: uint a, b: uint b):<>
  bool (a < b) = "mac#atspre_lt"
fun gt_uint1_uint1
  {a, b: int} (a: uint a, b: uint b):<>
  bool (a > b) = "mac#atspre_gt"
fun le_uint1_uint1
  {a, b: int} (a: uint a, b: uint b):<>
  bool (a <= b) = "mac#atspre_le"
fun ge_uint1_uint1
  {a, b: int} (a: uint a, b: uint b):<>
  bool (a >= b) = "mac#atspre_ge"
overload = with eq_uint1_uint1
overload != with ne_uint1_uint1
overload < with lt_uint1_uint1
overload > with gt_uint1_uint1
overload <= with le_uint1_uint1
overload >= with ge_uint1_uint1

fun add_uint1_uint1
  {a, b: int | a + b <= UINT_MAX}
  (a: uint a, b: uint b):<> uint (a+b)
  = "mac#atspre_add"
overload + with add_uint1_uint1

fun sub_uint1_uint1
  {a, b: int | a >= b}
  (a: uint a, b: uint b):<> uint (a-b)
  = "mac#atspre_sub"
overload - with sub_uint1_uint1

fun land_uint1_uint1
  {a, b: int}
  (a: uint a, b: uint b):<>
  [r: Uint | r <= a && r <= b] uint r
  = "mac#atspre_land"
overload land with land_uint1_uint1

fun lor_uint1_uint1
  {a, b: int}
  (a: uint a, b: uint b):<>
  [r: Uint | r >= a && r >= b && r <= a + b] uint r
  = "mac#atspre_lor"
overload lor with lor_uint1_uint1

fun div_uint1_uint1
  {a, b: int | b > 0}
  (a: uint a, b: uint b):<>
  [q: Uint | q <= a] uint q
  = "mac#atspre_div"
overload / with div_uint1_uint1

fun mod_uint1_uint1
  {a, b: int | b > 0}
  (a: uint a, b: uint b):<>
  [r: Uint | r < b] uint r
  = "mac#atspre_mod"
overload mod with mod_uint1_uint1

infixl ( / ) udiv2
fun udiv2
  {a, b: int | b > 0}
  (a: uint a, b: uint b):<>
  [q, r: Uint | q <= a && r < b] (DIVMOD (a, b, q, r) | uint q)
  = "mac#atspre_div"

fun umod2
  {a, b: int | b > 0}
  (a: uint a, b: uint b):<>
  [q, r: Uint | r < b] (DIVMOD (a, b, q, r) | uint r)
  = "mac#atspre_mod"

(* x needs at least nbits bits to store. *)
propdef needbits (x: int, nbits: int) =
  [nexp: nat | x < nexp] [x >= 0] [nbits >= 0] EXP2 (nbits, nexp)

fun ushl
  {x: int} {xbits: int} {n: Int | n <= UINT_BIT-xbits}
  (pf: needbits(x,xbits) |
   x: uint x, n: int n):<>
  [r:Uint] uint r
   = "mac#atspre_shl"

fun ushl2
  {x: int} {xbits: int} {n: Nat | n <= UINT_BIT-xbits}
  (pf: needbits(x,xbits) |
   x: uint x, n: int n):<>
  [r:Uint] (needbits(r,xbits+n) | uint r)
   = "mac#atspre_shl"

(* x << n == x * 2**n == y *)
propdef SHL (x: int, n: int, y: int) =
  [expn: pos] [y >= 0] (EXP2 (n, expn), MUL (x, expn, y))

prfun SHL_make {x, n: nat} (): [y: nat] SHL (x, n, y)

fun ushl3
  {x, n: nat} {y: Uint}
  (pf: SHL (x, n, y) |
   x: uint x, n: int n):<>
  uint y = "mac#atspre_shl"

fun shr_uint1_int1
  {x: int} {n: nat}
  (x: uint x, n: int n):<>
  [r:Uint] uint r
  = "mac#atspre_shr"
overload >> with shr_uint1_int1

fun ushr2
  {x: int} {xbits: int} {n: int | n <= xbits}
  (pf: needbits(x,xbits) |
   x: uint x, n: int n):<>
  [r:Uint] (needbits(r,xbits-n) | uint r)
  = "mac#atspre_shr"
