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
