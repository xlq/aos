(* Specifies the limit (one greater than the largest value)
   of an unindexed, unsigned integer base type. *)
absprop uint_limit (base: t@ype, lim: int)

abst@ype uintx (base: t@ype, lim: int, x: int) = base

castfn uintx_of_uint
  {dest_base: t@ype} {dest_lim: int}
  {x: nat | x < dest_lim}
  (pf_dest: uint_limit (dest_base, dest_lim)
    | x: uint x):<0>
  uintx (dest_base, dest_lim, x)

(* XXX: This assumes uint is always big enough! *)
castfn uint_of_uintx
  {src_base: t@ype} {src_lim: int}
  {x: nat}
  (x: uintx (src_base, src_lim, x)):<0>
  uint x

castfn uintx_of_uintx
  {dest_base: t@ype} {dest_lim: int}
  {src_base: t@ype} {src_lim: int}
  {x: nat | x < dest_lim && x < src_lim}
  (pf_dest: uint_limit (dest_base, dest_lim)
    | x: uintx (src_base, src_lim, x)):<0>
  uintx (dest_base, dest_lim, x)

symintr uintx_of
overload uintx_of with uintx_of_uintx
overload uintx_of with uintx_of_uint

fun add_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat | a + b < alim}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  uintx (abase, alim, a + b)
  = "mac#atspre_addmac"
overload + with add_uintx_uintx

fun add_uintx_int
  {abase: t@ype} {alim: int}
  {a: nat} {b: int | a + b >= 0 && a + b < alim}
  (a: uintx (abase, alim, a),
   b: int b):<0>
  uintx (abase, alim, a + b)
  = "mac#atspre_addmac"
overload + with add_uintx_int

fun sub_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat | a >= b && (a - b) < alim}
    (* XXX: This is incorrect if uint8 - uint16 is done
       as an 8-bit operation. *)
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  uintx (abase, alim, a - b)
  = "mac#atspre_submac"
overload - with add_uintx_uintx

fun shr_uintx_int
  {abase: t@ype} {alim: int}
  {a, b: nat | a < alim}
  (a: uintx (abase, alim, a),
   b: int b):<0>
  [r: nat | r <= a] uintx (abase, alim, r)
  = "mac@atspre_shrmac"
overload >> with shr_uintx_int

fun eq_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  bool (a == b)
  = "mac#atspre_eqmac"
overload = with eq_uintx_uintx

fun eq_uintx_int
  {abase: t@ype} {alim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: int b):<0>
  bool (a == b)
  = "mac#atspre_eqmac"
overload = with eq_uintx_int

fun ne_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  bool (a <> b)
  = "mac#atspre_nemac"
overload != with ne_uintx_uintx

fun lt_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  bool (a < b)
  = "mac#atspre_ltmac"
overload < with lt_uintx_uintx

fun gt_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  bool (a > b)
  = "mac#atspre_gtmac"
overload > with gt_uintx_uintx

fun gt_uintx_int
  {abase: t@ype} {alim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: int b):<0>
  bool (a > b)
  = "mac#atspre_gtmac"
overload > with gt_uintx_int

fun le_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  bool (a <= b)
  = "mac#atspre_lemac"
overload <= with le_uintx_uintx

(* NOTE: (a land b) can be no larger than min(a, b) *)

fun land_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  [r: nat | r < alim] uintx (abase, alim, r)
  = "mac#atspre_landmac"
overload land with land_uintx_uintx

fun land_uintx_int
  {abase: t@ype} {alim: int}
  {a, b: nat | b <= alim}
  (a: uintx (abase, alim, a),
   b: int b):<0>
  [r: nat | r < alim] uintx (abase, alim, r)
  = "mac#atspre_landmac"
overload land with land_uintx_int

fun lor_uintx_uintx
  {abase: t@ype} {alim: int}
  {bbase: t@ype} {blim: int | blim <= alim}
  {a, b: nat}
  (a: uintx (abase, alim, a),
   b: uintx (bbase, blim, b)):<0>
  [r: nat | r < alim] uintx (abase, alim, r)
  = "mac#atspre_lormac"
overload lor with lor_uintx_uintx

fun lor_uintx_int
  {abase: t@ype} {alim: int}
  {a, b: nat | b <= alim}
  (a: uintx (abase, alim, a),
   b: int b):<0>
  [r: nat | r < alim] uintx (abase, alim, r)
  = "mac#atspre_lormac"
overload lor with lor_uintx_int



%{#
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
%}

praxi uint8: uint_limit(uint8, 0x100)
praxi uint16: uint_limit(uint16, 0x10000)
praxi uint32: uint_limit(uint32, 0x100000000)

sortdef uint8 = {x: nat | x < 0x100}
sortdef uint16 = {x: nat | x < 0x10000}
sortdef uint32 = {x: nat | x < 0x100000000}

typedef uint8 (x: int) = uintx(uint8, 0x100, x)
typedef uint16 (x: int) = uintx(uint16, 0x10000, x)
typedef uint32 (x: int) = uintx(uint32, 0x100000000, x)

typedef uint8 = [x: uint8] uint8 x
typedef uint16 = [x: uint16] uint16 x
typedef uint32 = [x: uint32] uint32 x

castfn uint8_of {x: uint8} (x: int x): uint8 x
castfn uint16_of {x: uint16} (x: int x): uint16 x
castfn uint32_of {x: uint32} (x: int x): uint32 x
