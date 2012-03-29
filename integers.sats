
(* I seem to be missing option_p so I define it here. *)

dataprop option_p (P: prop+, bool) =
  | Some_p (P, true) of P
  | None_p (P, false) of ()

%{#

#ifndef INTEGERS_H
#define INTEGERS_H
  #define atspre_addmac(a,b) ((a)+(b))
  #define atspre_submac(a,b) ((a)-(b))
  #define atspre_shrmac(a,b) ((a)>>(b))
  #define atspre_eqmac(a,b) ((a)==(b))
  #define atspre_nemac(a,b) ((a)!=(b))
  #define atspre_ltmac(a,b) ((a)<(b))
  #define atspre_gtmac(a,b) ((a)>(b))
  #define atspre_lemac(a,b) ((a)<=(b))
  #define atspre_gemac(a,b) ((a)>=(b))
  #define atspre_landmac(a,b) ((a)&(b))
  #define atspre_lormac(a,b) ((a)|(b))
  #define atspre_mulmac(a,b) ((a)*(b))
  #define atspre_divmac(a,b) ((a)/(b))

  typedef struct {
    ats_bool_type overflow;
    uint32_t result;
  } mul_uint32_result;

  static inline mul_uint32_result
  integers_mul_uint32(uint32_t a, uint32_t b)
  {
    uint64_t c = a;
    mul_uint32_result r;
    c *= b;
    r.overflow = (c > 0xFFFFFFFF);
    r.result = c;
    return r;
  }
#endif

%}

#define UINT8_LIM 0x100
#define UINT16_LIM 0x10000
#define UINT32_LIM 0x100000000
abst@ype uint8 (x: int) = uint8
abst@ype uint16 (x: int) = uint16
abst@ype uint32 (x: int) = uint32
sortdef uint8 = {x: nat | x < UINT8_LIM}
sortdef uint16 = {x: nat | x < UINT16_LIM}
sortdef uint32 = {x: nat | x < UINT32_LIM}
typedef uint8 = [x: uint8] uint8 x
typedef uint16 = [x: uint16] uint16 x
typedef uint32 = [x: uint32] uint32 x

castfn uint8_of_int {x: uint8} (x: int x):<> uint8 x
castfn uint8_of_uint {x: uint8} (x: uint x):<> uint8 x
castfn uint8_of_uint16 {x: uint8} (x: uint16 x):<> uint8 x
castfn uint8_of_uint32 {x: uint8} (x: uint32 x):<> uint8 x
symintr uint8_of
overload uint8_of with uint8_of_int
overload uint8_of with uint8_of_uint
overload uint8_of with uint8_of_uint16
overload uint8_of with uint8_of_uint32

castfn uint16_of_int {x: uint16} (x: int x):<> uint16 x
castfn uint16_of_uint {x: uint16} (x: uint x):<> uint16 x
castfn uint16_of_uint8 {x: uint8} (x: uint8 x):<> uint16 x
castfn uint16_of_uint32 {x: uint16} (x: uint32 x):<> uint16 x
symintr uint16_of
overload uint16_of with uint16_of_int
overload uint16_of with uint16_of_uint
overload uint16_of with uint16_of_uint8
overload uint16_of with uint16_of_uint32

castfn uint32_of_int {x: uint32} (x: int x):<> uint32 x
castfn uint32_of_uint {x: uint32} (x: uint x):<> uint32 x
castfn uint32_of_uint8 {x: uint8} (x: uint8 x):<> uint32 x
castfn uint32_of_uint16 {x: uint16} (x: uint16 x):<> uint32 x
symintr uint32_of
overload uint32_of with uint16_of_int
overload uint32_of with uint16_of_uint
overload uint32_of with uint16_of_uint8
overload uint32_of with uint16_of_uint32

castfn uint_of_uint8 {x: uint8} (x: uint8 x):<> uint x
castfn uint_of_uint16 {x: uint16} (x: uint16 x):<> uint x
castfn uint_of_uint32 {x: uint32} (x: uint32 x):<> uint x
castfn int_of_uint8 {x: uint8} (x: uint8 x):<> int x
castfn int_of_uint16 {x: uint16} (x: uint16 x):<> int x
castfn int_of_uint32 {x: uint32} (x: uint32 x):<> int x
overload uint_of with uint_of_uint8
overload uint_of with uint_of_uint16
overload uint_of with uint_of_uint32
overload int_of with int_of_uint8
overload int_of with int_of_uint16
overload int_of with int_of_uint32

fun add_uint8_uint8 {a, b: uint8 | a + b < UINT8_LIM} (a: uint8 a, b: uint8 b):<> uint8 (a + b) = "mac#atspre_addmac"
fun sub_uint8_uint8 {a, b: uint8 | a >= b} (a: uint8 a, b: uint8 b):<> uint8 (a - b) = "mac#atspre_submac"
fun shr_uint8_int {a: uint8} {b: nat} (a: uint8 a, b: int b):<> [r: nat | r <= a] uint8 r = "mac#atspre_shrmac"
fun eq_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> bool (a == b) = "mac#atspre_eqmac"
fun ne_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> bool (a <> b) = "mac#atspre_nemac"
fun lt_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> bool (a < b) = "mac#atspre_ltmac"
fun gt_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> bool (a > b) = "mac#atspre_gtmac"
fun le_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> bool (a <= b) = "mac#atspre_lemac"
fun ge_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> bool (a >= b) = "mac#atspre_gemac"
fun land_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> [r: uint8 | r <= a && r <= b] uint8 r = "mac#atspre_landmac"
fun lor_uint8_uint8 {a, b: uint8} (a: uint8 a, b: uint8 b):<> [r: uint8 | r >= a && r >= b] uint8 r = "mac#atspre_lormac"

fun add_uint16_uint16 {a, b: uint16 | a + b < UINT16_LIM} (a: uint16 a, b: uint16 b):<> uint16 (a + b) = "mac#atspre_addmac"
fun sub_uint16_uint16 {a, b: uint16 | a >= b} (a: uint16 a, b: uint16 b):<> uint16 (a - b) = "mac#atspre_submac"
fun shr_uint16_int {a: uint16} {b: nat} (a: uint16 a, b: int b):<> [r: nat | r <= a] uint16 r = "mac#atspre_shrmac"
fun eq_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> bool (a == b) = "mac#atspre_eqmac"
fun ne_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> bool (a <> b) = "mac#atspre_nemac"
fun lt_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> bool (a < b) = "mac#atspre_ltmac"
fun gt_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> bool (a > b) = "mac#atspre_gtmac"
fun le_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> bool (a <= b) = "mac#atspre_lemac"
fun ge_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> bool (a >= b) = "mac#atspre_gemac"
fun land_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> [r: uint16 | r <= a && r <= b] uint16 r = "mac#atspre_landmac"
fun lor_uint16_uint16 {a, b: uint16} (a: uint16 a, b: uint16 b):<> [r: uint16 | r >= a && r >= b] uint16 r = "mac#atspre_lormac"

fun add_uint32_uint32 {a, b: uint32 | a + b < UINT32_LIM} (a: uint32 a, b: uint32 b):<> uint32 (a + b) = "mac#atspre_addmac"
fun sub_uint32_uint32 {a, b: uint32 | a >= b} (a: uint32 a, b: uint32 b):<> uint32 (a - b) = "mac#atspre_submac"
fun shr_uint32_int {a: uint32} {b: nat} (a: uint32 a, b: int b):<> [r: nat | r <= a] uint32 r = "mac#atspre_shrmac"
fun eq_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> bool (a == b) = "mac#atspre_eqmac"
fun ne_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> bool (a <> b) = "mac#atspre_nemac"
fun lt_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> bool (a < b) = "mac#atspre_ltmac"
fun gt_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> bool (a > b) = "mac#atspre_gtmac"
fun le_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> bool (a <= b) = "mac#atspre_lemac"
fun ge_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> bool (a >= b) = "mac#atspre_gemac"
fun land_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> [r: uint32 | r <= a && r <= b] uint32 r = "mac#atspre_landmac"
fun lor_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> [r: uint32 | r >= a && r >= b] uint32 r = "mac#atspre_lormac"
typedef mul_uint32_result (overflow: bool, result: int) = $extype_struct "mul_uint32_result" of { overflow = bool overflow, result = uint32 result }
fun mul_uint32_uint32 {a, b: uint32} (a: uint32 a, b: uint32 b):<> [overflow: bool] [result: uint32] (option_p (MUL(a,b,result), ~overflow) | mul_uint32_result (overflow, result)) = "mac#integers_mul_uint32"

(*
fun div_uint32_uint32 {a, b: uint32 | b > 0} (a: uint32 a, b: uint32 b):<> uint32 (a / b) = "mac@atspre_divmac"
dataprop mul_uint32_will_fit (int, int) =
  | {a, b: uint32 | b > 0} {divr: nat | divr < a} mul_uint32_div (a, b) of (DIV (UINT32_LIM, b, divr))
  | {a: uint32} mul_uint32_0 (a, 0) of ()
fun test_mul_uint32_will_fit {a, b: uint32} (a: uint32 a, b: uint32 b):<> [r: bool] (option_p (mul_uint32_will_fit (a, b), r) | bool r)
fun mul_uint32_uint32 {a, b: uint32} (pf: mul_uint32_will_fit (a, b) | a: uint32 a, b: uint32 b): uint32 (a * b) = "mac#atspre_mulmac"
*)

fun add_uint8_int {a, b: uint8 | a + b < UINT8_LIM} (a: uint8 a, b: int b):<> uint8 (a + b) = "mac#atspre_addmac"
fun sub_uint8_int {a, b: uint8 | a >= b} (a: uint8 a, b: int b):<> uint8 (a - b) = "mac#atspre_submac"
fun eq_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> bool (a == b) = "mac#atspre_eqmac"
fun ne_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> bool (a <> b) = "mac#atspre_nemac"
fun lt_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> bool (a < b) = "mac#atspre_ltmac"
fun gt_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> bool (a > b) = "mac#atspre_gtmac"
fun le_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> bool (a <= b) = "mac#atspre_lemac"
fun ge_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> bool (a >= b) = "mac#atspre_gemac"
fun land_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> [r: uint8 | r <= a && r <= b] uint8 r = "mac#atspre_landmac"
fun lor_uint8_int {a, b: uint8} (a: uint8 a, b: int b):<> [r: uint8 | r >= a && r >= b] uint8 r = "mac#atspre_lormac"

fun add_uint16_int {a, b: uint16 | a + b < UINT16_LIM} (a: uint16 a, b: int b):<> uint16 (a + b) = "mac#atspre_addmac"
fun sub_uint16_int {a, b: uint16 | a >= b} (a: uint16 a, b: int b):<> uint16 (a - b) = "mac#atspre_submac"
fun eq_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> bool (a == b) = "mac#atspre_eqmac"
fun ne_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> bool (a <> b) = "mac#atspre_nemac"
fun lt_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> bool (a < b) = "mac#atspre_ltmac"
fun gt_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> bool (a > b) = "mac#atspre_gtmac"
fun le_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> bool (a <= b) = "mac#atspre_lemac"
fun ge_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> bool (a >= b) = "mac#atspre_gemac"
fun land_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> [r: uint16 | r <= a && r <= b] uint16 r = "mac#atspre_landmac"
fun lor_uint16_int {a, b: uint16} (a: uint16 a, b: int b):<> [r: uint16 | r >= a && r >= b] uint16 r = "mac#atspre_lormac"

fun add_uint32_int {a, b: uint32 | a + b < UINT32_LIM} (a: uint32 a, b: int b):<> uint32 (a + b) = "mac#atspre_addmac"
fun sub_uint32_int {a, b: uint32 | a >= b} (a: uint32 a, b: int b):<> uint32 (a - b) = "mac#atspre_submac"
fun eq_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> bool (a == b) = "mac#atspre_eqmac"
fun ne_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> bool (a <> b) = "mac#atspre_nemac"
fun lt_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> bool (a < b) = "mac#atspre_ltmac"
fun gt_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> bool (a > b) = "mac#atspre_gtmac"
fun le_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> bool (a <= b) = "mac#atspre_lemac"
fun ge_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> bool (a >= b) = "mac#atspre_gemac"
fun land_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> [r: uint32 | r <= a && r <= b] uint32 r = "mac#atspre_landmac"
fun lor_uint32_int {a, b: uint32} (a: uint32 a, b: int b):<> [r: uint32 | r >= a && r >= b] uint32 r = "mac#atspre_lormac"

overload + with add_uint8_uint8
overload - with sub_uint8_uint8
overload >> with shr_uint8_int
overload = with eq_uint8_uint8
overload != with ne_uint8_uint8
overload < with lt_uint8_uint8
overload > with gt_uint8_uint8
overload <= with le_uint8_uint8
overload >= with ge_uint8_uint8
overload land with land_uint8_uint8
overload lor with lor_uint8_uint8

overload + with add_uint16_uint16
overload - with sub_uint16_uint16
overload >> with shr_uint16_int
overload = with eq_uint16_uint16
overload != with ne_uint16_uint16
overload < with lt_uint16_uint16
overload > with gt_uint16_uint16
overload <= with le_uint16_uint16
overload >= with ge_uint16_uint16
overload land with land_uint16_uint16
overload lor with lor_uint16_uint16

overload + with add_uint32_uint32
overload - with sub_uint32_uint32
overload >> with shr_uint32_int
overload = with eq_uint32_uint32
overload != with ne_uint32_uint32
overload < with lt_uint32_uint32
overload > with gt_uint32_uint32
overload <= with le_uint32_uint32
overload >= with ge_uint32_uint32
overload land with land_uint32_uint32
overload lor with lor_uint32_uint32
overload * with mul_uint32_uint32
overload / with div_uint32_uint32

overload + with add_uint8_int
overload - with sub_uint8_int
overload = with eq_uint8_int
overload != with ne_uint8_int
overload < with lt_uint8_int
overload > with gt_uint8_int
overload <= with le_uint8_int
overload >= with ge_uint8_int
overload land with land_uint8_int
overload lor with lor_uint8_int

overload + with add_uint16_int
overload - with sub_uint16_int
overload = with eq_uint16_int
overload != with ne_uint16_int
overload < with lt_uint16_int
overload > with gt_uint16_int
overload <= with le_uint16_int
overload >= with ge_uint16_int
overload land with land_uint16_int
overload lor with lor_uint16_int

overload + with add_uint32_int
overload - with sub_uint32_int
overload = with eq_uint32_int
overload != with ne_uint32_int
overload < with lt_uint32_int
overload > with gt_uint32_int
overload <= with le_uint32_int
overload >= with ge_uint32_int
overload land with land_uint32_int
overload lor with lor_uint32_int

sortdef uintn = uint32
typedef uintn (x: int) = uint32 x
typedef uintn = [x: uint32] uintn x
symintr uintn_of
overload uintn_of with uint32_of_int
overload uintn_of with uint32_of_uint
overload uintn_of with uint32_of_uint8
overload uintn_of with uint32_of_uint16
