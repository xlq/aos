(* PC serial port output. *)

staload "integers.sats"

typedef _serial_port =
  @{
    initialised = bool,
    port = uint16,
    irq = int
  }

abst@ype serial_port (initialised: bool) = _serial_port

val new: serial_port false

fun init
  {com_number: int | com_number >= 1 && com_number <= 4}
  (port: &serial_port false >> serial_port success,
   com_number: int com_number,
   baud: int):
  #[success: bool]
  bool success

fun is_initialised
  {initialised: bool}
  (port: &serial_port initialised): bool initialised

fun send_char
  (port: &serial_port true,
   ch: char): void

fun send_string
  {len: nat}
  (port: &serial_port true,
   len: size_t len,
   str: string len): void
