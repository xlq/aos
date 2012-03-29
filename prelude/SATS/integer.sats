staload "prelude/limits.sats"

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

fun eq_int1_int1
  {a, b: Int} (a: int a, b: int b):<>
  bool (a == b) = "mac#atspre_eq"
fun ne_int1_int1
  {a, b: Int} (a: int a, b: int b):<>
  bool (a <> b) = "mac#atspre_ne"
fun lt_int1_int1
  {a, b: Int} (a: int a, b: int b):<>
  bool (a < b) = "mac#atspre_lt"
fun gt_int1_int1
  {a, b: Int} (a: int a, b: int b):<>
  bool (a > b) = "mac#atspre_gt"
fun le_int1_int1
  {a, b: Int} (a: int a, b: int b):<>
  bool (a <= b) = "mac#atspre_le"
fun ge_int1_int1
  {a, b: Int} (a: int a, b: int b):<>
  bool (a >= b) = "mac#atspre_ge"
overload = with eq_int1_int1
overload != with ne_int1_int1
overload < with lt_int1_int1
overload > with gt_int1_int1
overload <= with le_int1_int1
overload >= with ge_int1_int1

fun add_int1_int1
  {a, b: Int | a + b >= INT_MIN && a + b <= INT_MAX}
  (a: int a, b: int b):<> int (a + b)
  = "mac#atspre_add"
overload + with add_int1_int1

fun sub_int1_int1
  {a, b: Int | a - b >= INT_MIN && a - b <= INT_MAX}
  (a: int a, b: int b):<> int (a - b)
  = "mac#atspre_sub"
overload - with sub_int1_int1

fun premul_int1_int1
  {a, b: Int} (a: int a, b: int b):<>
  bool (a * b >= INT_MIN && a * b <= INT_MAX)
  = "atspre_premul_int1_int1"
overload *? with premul_int1_int1

fun mul_int1_int1
  {a, b: Int | a * b >= INT_MIN && a * b <= INT_MAX}
  (a: int a, b: int b):<> int (a * b)
  = "mac#atspre_mul"
overload * with mul_int1_int1

fun imul2
  {a, b: Int | a * b >= INT_MIN && a * b <= INT_MAX}
  (a: int a, b: int b):<> [r: Int] (MUL(a,b,r) | int r)
  = "mac#atspre_mul"
