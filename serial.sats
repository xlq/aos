(* PC serial port output. *)

staload "prelude/limits.sats"

abst@ype serial_port = 
  @{
    port = uint16,
    irq = int
  }

fun init
  {l: agz}
  {com_number: int | com_number >= 1 && com_number <= 4}
  (pf_port: serial_port? @ l |
   port: ptr l,
   com_number: int com_number,
   baud: uint):
  [success: bool] (choice_v (success, serial_port @ l, serial_port? @ l)
    | bool success)

fun send_char
  (port: &serial_port,
   ch: char): void

fun send_string
  {len: Int}
  (port: &serial_port,
   len: int len,
   str: string len): void
