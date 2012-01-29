staload "prelude/limits.sats"

absviewt@ype console = @(int, int, int, int, uint8, ptr)

abst@ype colour = int
val black: colour
val blue: colour
val green: colour
val cyan: colour
val red: colour
val magenta: colour
val brown: colour
val white: colour
val grey: colour
val bright_blue: colour
val bright_green: colour
val bright_cyan: colour
val bright_red: colour
val bright_magenta: colour
val bright_yellow: colour
val bright_white: colour

(* Initialise a text console for VRAM at 0xB8000. *)
fun init_B8000 {l:agz}
  (pf_con: console? @ l |
   con: ptr l): [success:bool]
  (choice_v (success, console @ l, console? @ l) |
   bool success)

fun finit (con: &console >> console?): void

fun default_colours (con: &console): void
fun set_colour (con: &console, fg: colour): void
fun set_background (con: &console, bg: colour): void

symintr put

fun put_char (con: &console, ch: c1har): void
overload put with put_char

fun put_string {len:Nat}
  (con: &console, len: int len, str: string len): void
overload put with put_string
