(* Required by compiler. *)
fun main_void (): void
fun main_argc_argv {n: igz}
  (argc: int n, argv: &(@[ptr][n])): void
prfun main_dummy (): void

symintr byte_of ubyte_of byte1_of ubyte1_of
symintr short_of ushort_of short1_of ushort1_of
symintr int_of uint_of int1_of uint1_of
symintr long_of ulong_of long1_of ulong1_of
symintr llong_of ullong_of llong1_of ullong1_of
symintr uint8_of uint16_of uint32_of uint64_of
symintr uint8_1_of uint16_1_of uint32_1_of uint64_1_of
symintr + - * / mod gcd
symintr < > <= >= = !=
symintr && || << >> land lor not ~
symintr *?
infixl ( * ) *?

val true: bool true = "mac#true"
val false: bool false = "mac#false"

val {T: viewt@ype} sizeof: size_t (sizeof T)

(* "opt" is a box for storing a possibly initialised viewtype. *)
praxi opt_some {vt:viewt@ype} (x: !vt >> opt(vt,true)):<> void
praxi opt_none {vt:viewt@ype} (x: !vt? >> opt(vt,false)):<> void
praxi opt_unsome {vt:viewt@ype} (x: !opt(vt,true) >> vt):<> void
praxi opt_unnone {vt:viewt@ype} (x: !opt(vt,false) >> vt?):<> void

// Only for globals.
fun vbox_make_view_ptr
  {vt:viewt@ype} {l:addr}
  (pf: vt @ l | p: ptr l): (vbox (vt @ l) | void)
  = "atspre_vbox_make_view_ptr"
