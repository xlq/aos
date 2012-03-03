(* PC serial port output. *)

staload "prelude/limits.sats"

abst@ype serial_port = 
  @{
    port = uint16,
    irq = int
  }

fun init
  {com_number: int | com_number >= 1 && com_number <= 4}
  {baud: Uint | baud > 0}
  (port: &serial_port? >> opt(serial_port, success),
   com_number: int com_number,
   baud: uint baud):<> #[success: bool] bool success

fun send_char
  (port: &serial_port,
   ch: char):<!ntm> void

fun send_string
  {len: Int}
  (port: &serial_port,
   len: int len,
   str: string len):<!ntm> void
