(* Required by compiler. *)
fun main_void (): void
fun main_argc_argv {n: igz}
  (argc: int n, argv: &(@[ptr][n])): void
prfun main_dummy (): void

symintr int_of uint_of int1_of uint1_of
symintr uint8_of uint16_of uint32_of
symintr + - * / mod gcd
symintr < > <= >= = !=
symintr && || << >> land lor not
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

fun vbox_make_view_ptr
  {vt:viewt@ype} {l:addr}
  (pf: vt @ l | p: ptr l): (vbox (vt @ l) | void)
  = "atspre_vbox_make_view_ptr"
