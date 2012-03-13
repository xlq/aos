fun eq_ptr_ptr (a: ptr, b: ptr):<> bool = "mac#atspre_eq"
fun ne_ptr_ptr (a: ptr, b: ptr):<> bool = "mac#atspre_ne"
fun lt_ptr_ptr (a: ptr, b: ptr):<> bool = "mac#atspre_lt"
fun gt_ptr_ptr (a: ptr, b: ptr):<> bool = "mac#atspre_gt"
fun le_ptr_ptr (a: ptr, b: ptr):<> bool = "mac#atspre_le"
fun ge_ptr_ptr (a: ptr, b: ptr):<> bool = "mac#atspre_ge"
overload = with eq_ptr_ptr
overload != with ne_ptr_ptr
overload < with lt_ptr_ptr
overload > with gt_ptr_ptr
overload <= with le_ptr_ptr
overload >= with ge_ptr_ptr

fun eq_ptr1_ptr1 {a, b: addr} (a: ptr a, b: ptr b):<> bool (a == b) = "mac#atspre_eq"
fun ne_ptr1_ptr1 {a, b: addr} (a: ptr a, b: ptr b):<> bool (a <> b) = "mac#atspre_ne"
fun lt_ptr1_ptr1 {a, b: addr} (a: ptr a, b: ptr b):<> bool (a < b) = "mac#atspre_lt"
fun gt_ptr1_ptr1 {a, b: addr} (a: ptr a, b: ptr b):<> bool (a > b) = "mac#atspre_gt"
fun le_ptr1_ptr1 {a, b: addr} (a: ptr a, b: ptr b):<> bool (a <= b) = "mac#atspre_le"
fun ge_ptr1_ptr1 {a, b: addr} (a: ptr a, b: ptr b):<> bool (a >= b) = "mac#atspre_ge"
overload = with eq_ptr1_ptr1
overload != with ne_ptr1_ptr1
overload < with lt_ptr1_ptr1
overload > with gt_ptr1_ptr1
overload <= with le_ptr1_ptr1
overload >= with ge_ptr1_ptr1
