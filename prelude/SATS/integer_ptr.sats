symintr uintptr_of uintptr1_of

castfn uintptr_of_ptr (p: ptr):<> uintptr_t
castfn uintptr_of_ptr1 {l: addr} (p: ptr l):<> uintptr_t
castfn uintptr1_of_ptr (p: ptr):<> [x: Uintptr] uintptr_t x
castfn uintptr1_of_ptr1 {l: addr} (p: ptr l):<> [x: Uintptr] uintptr_t x
castfn uintptr_of_uint1 {x: Uintptr} (x: uint x):<> uintptr_t
castfn uintptr1_of_uint1 {x: Uintptr} (x: uint x):<> uintptr_t x
castfn uint1_of_uintptr1 {x: Uint} (x: uintptr_t x):<> uint x

overload uintptr_of with uintptr_of_ptr
overload uintptr_of with uintptr_of_ptr1
overload uintptr_of with uintptr_of_uint1
overload uintptr1_of with uintptr1_of_ptr
overload uintptr1_of with uintptr1_of_ptr1
overload uintptr1_of with uintptr1_of_uint1
overload uint1_of with uint1_of_uintptr1

fun land_uintptr_uintptr
  (a: uintptr_t, b: uintptr_t):<>
  uintptr_t = "mac#atspre_land"

fun lor_uintptr_uintptr
  (a: uintptr_t, b: uintptr_t):<>
  uintptr_t = "mac#atspre_lor"

fun shr_uintptr_int (a: uintptr_t, n: Int):<>
  uintptr_t = "mac#atspre_shr"

fun land_uintptr1_uintptr1
  {a, b: Uintptr}
  (a: uintptr_t a, b: uintptr_t b):<>
  [c: Uintptr | c <= a && c <= b]
  uintptr_t c = "mac#atspre_land"

fun lor_uintptr1_uintptr1
  {a, b: Uintptr}
  (a: uintptr_t a, b: uintptr_t b):<>
  [c: Uintptr | c >= a && c >= b && c <= a + b]
  uintptr_t c = "mac#atspre_lor"

fun shr_uintptr1_int1
  {a: Uintptr} {n: nat}
  (a: uintptr_t a, n: int n):<>
  [r: Uintptr] uintptr_t r = "mac#atspre_shr"

overload land with land_uintptr_uintptr
overload lor with lor_uintptr_uintptr
overload >> with shr_uintptr_int
overload land with land_uintptr1_uintptr1
overload lor with lor_uintptr1_uintptr1
overload >> with shr_uintptr1_int1
