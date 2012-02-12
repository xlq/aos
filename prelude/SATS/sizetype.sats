symintr size1_of

castfn int1_of_size1 {x: Int} (x: size_t x):<> int x
overload int1_of with int1_of_size1

castfn size1_of_int1 {x: Size} (x: int x):<> size_t x
overload size1_of with size1_of_int1

fun eq_size1_size1
  {a, b: int} (a: size_t a, b: size_t b):<>
  bool (a == b) = "mac#atspre_eq"
fun ne_size1_size1
  {a, b: int} (a: size_t a, b: size_t b):<>
  bool (a <> b) = "mac#atspre_ne"
fun lt_size1_size1
  {a, b: int} (a: size_t a, b: size_t b):<>
  bool (a < b) = "mac#atspre_lt"
fun gt_size1_size1
  {a, b: int} (a: size_t a, b: size_t b):<>
  bool (a > b) = "mac#atspre_gt"
fun le_size1_size1
  {a, b: int} (a: size_t a, b: size_t b):<>
  bool (a <= b) = "mac#atspre_le"
fun ge_size1_size1
  {a, b: int} (a: size_t a, b: size_t b):<>
  bool (a >= b) = "mac#atspre_ge"
overload = with eq_size1_size1
overload != with ne_size1_size1
overload < with lt_size1_size1
overload > with gt_size1_size1
overload <= with le_size1_size1
overload >= with ge_size1_size1
