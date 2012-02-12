staload "prelude/limits.sats"

castfn uint8_of_uint {a: Uint8} (a: uint a):<> uint8
castfn uint_of_uint8 (a: uint8):<> [r: Uint8] uint r

castfn uint16_of_uint {a: Uint16} (a: uint a):<> uint16
castfn uint_of_uint16 (a: uint16):<> [r: Uint16] uint r

castfn uint32_of_uint {a: Uint32} (a: uint a):<> uint32
castfn uint_of_uint32 (a: uint32):<> [r: Uint32] uint r

overload uint8_of with uint8_of_uint
overload uint16_of with uint16_of_uint
overload uint32_of with uint32_of_uint

overload uint_of with uint_of_uint8
overload uint_of with uint_of_uint16
overload uint_of with uint_of_uint32

fun land_uint8_uint8 (a: uint8, b: uint8):<> uint8 = "mac#atspre_land"
fun lor_uint8_uint8 (a: uint8, b: uint8):<> uint8 = "mac#atspre_lor"
fun lt_uint8_uint8 (a: uint8, b: uint8):<> bool = "mac#atspre_lt"
fun gt_uint8_uint8 (a: uint8, b: uint8):<> bool = "mac#atspre_gt"
fun le_uint8_uint8 (a: uint8, b: uint8):<> bool = "mac#atspre_le"
fun ge_uint8_uint8 (a: uint8, b: uint8):<> bool = "mac#atspre_ge"
fun eq_uint8_uint8 (a: uint8, b: uint8):<> bool = "mac#atspre_eq"
fun ne_uint8_uint8 (a: uint8, b: uint8):<> bool = "mac#atspre_ne"

fun land_uint16_uint16 (a: uint16, b: uint16):<> uint16 = "mac#atspre_land"
fun lor_uint16_uint16 (a: uint16, b: uint16):<> uint16 = "mac#atspre_lor"
fun lt_uint16_uint16 (a: uint16, b: uint16):<> bool = "mac#atspre_lt"
fun gt_uint16_uint16 (a: uint16, b: uint16):<> bool = "mac#atspre_gt"
fun le_uint16_uint16 (a: uint16, b: uint16):<> bool = "mac#atspre_le"
fun ge_uint16_uint16 (a: uint16, b: uint16):<> bool = "mac#atspre_ge"
fun eq_uint16_uint16 (a: uint16, b: uint16):<> bool = "mac#atspre_eq"
fun ne_uint16_uint16 (a: uint16, b: uint16):<> bool = "mac#atspre_ne"

fun land_uint32_uint32 (a: uint32, b: uint32):<> uint32 = "mac#atspre_land"
fun lor_uint32_uint32 (a: uint32, b: uint32):<> uint32 = "mac#atspre_lor"
fun lt_uint32_uint32 (a: uint32, b: uint32):<> bool = "mac#atspre_lt"
fun gt_uint32_uint32 (a: uint32, b: uint32):<> bool = "mac#atspre_gt"
fun le_uint32_uint32 (a: uint32, b: uint32):<> bool = "mac#atspre_le"
fun ge_uint32_uint32 (a: uint32, b: uint32):<> bool = "mac#atspre_ge"
fun eq_uint32_uint32 (a: uint32, b: uint32):<> bool = "mac#atspre_eq"
fun ne_uint32_uint32 (a: uint32, b: uint32):<> bool = "mac#atspre_ne"

overload land with land_uint8_uint8
overload lor with lor_uint8_uint8
overload < with lt_uint8_uint8
overload > with gt_uint8_uint8
overload <= with le_uint8_uint8
overload >= with ge_uint8_uint8
overload = with eq_uint8_uint8
overload != with ne_uint8_uint8

overload land with land_uint16_uint16
overload lor with lor_uint16_uint16
overload < with lt_uint16_uint16
overload > with gt_uint16_uint16
overload <= with le_uint16_uint16
overload >= with ge_uint16_uint16
overload = with eq_uint16_uint16
overload != with ne_uint16_uint16

overload land with land_uint32_uint32
overload lor with lor_uint32_uint32
overload < with lt_uint32_uint32
overload > with gt_uint32_uint32
overload <= with le_uint32_uint32
overload >= with ge_uint32_uint32
overload = with eq_uint32_uint32
overload != with ne_uint32_uint32
