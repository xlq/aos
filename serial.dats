staload "serial.sats"
staload "portio.sats"

typedef port_t = [x: Nat | x + 8 <= UINT16_MAX] uint x

assume serial_port =
  @{
    port = port_t,
    irq = int
  }

val COM1_IRQ = 4
val COM2_IRQ = 3
val COM1_BASE = 0x3F8u
val COM2_BASE = 0x2F8u
val COM3_BASE = 0x3E8u
val COM4_BASE = 0x2E8u

(* Is a UART present? *)
fn detect_uart (port: &serial_port):<> bool =
  let
    val tmp = inb (uint16_of (port.port + 4u))
  in
    outb (uint16_of (port.port + 4u), uint8_of 0x10u);
    if (inb (uint16_of (port.port + 6u)) land uint8_of 0xF0u) > uint8_of 0u then begin
      false
    end else begin
      outb (uint16_of (port.port + 4u), uint8_of 0x1Fu);
      if (inb (uint16_of (port.port + 6u)) land uint8_of 0xF0u)
        != uint8_of 0xF0u then false
      else begin
        (* restore tmp *)
        outb (uint16_of (port.port + 4u), tmp);
        true
      end
    end
  end

implement init (port, com_number, baud) =
let
  val (portnum, irq) = case+ com_number of
    | 1 => (COM1_BASE, COM1_IRQ)
    | 2 => (COM2_BASE, COM2_IRQ)
    | 3 => (COM3_BASE, COM1_IRQ)
    | 4 => (COM4_BASE, COM2_IRQ)
in
  port := @{ port = portnum, irq = irq };
  if not (detect_uart port) then
    (* No UART is present. *)
    let prval () = opt_none {serial_port} port in false; end
  else
    let val divisor = 115200u / baud in
      if divisor > uint1_of UINT16_MAX then
        (* Baud rate is too low! *)
        let prval () = opt_none {serial_port} port in false; end
      else begin
        outb (uint16_of (port.port + 1u), uint8_of 0x00u); // disable all interrupts
        outb (uint16_of (port.port + 3u), uint8_of 0x80u); // enable 'DLAB' - baud rate divisor
        outb (uint16_of (port.port + 0u), uint8_of (divisor land 0xFFu)); // divisor (lower)
        outb (uint16_of (port.port + 1u), uint8_of (0xFFu land (divisor >> 8))); // divisor (upper)
        outb (uint16_of (port.port + 3u), uint8_of 0x03u); // 8 bits, no parity, one stop bit
        outb (uint16_of (port.port + 2u), uint8_of 0xC7u); // enable FIFO, clear them, with 14 byte threshold
        outb (uint16_of (port.port + 4u), uint8_of 0x0Bu); // enable something?
        outb (uint16_of (port.port + 4u), inb (uint16_of (port.port + 4u)) lor uint8_of 8u); // set OUT2 bit to enable interrupts
        outb (uint16_of (port.port + 1u), uint8_of 0x01u); // enable ERBFI (receiver buffer full interrupt)
        (* Success. *)
        let prval () = opt_some {serial_port} port in true; end
      end
    end
end

fn sanitise_output (port: &serial_port, ch: char):<!ntm> char =
  case+ ch of
    | '\n' => (send_char (port, '\r'); '\n') (* LF -> CRLF *)
    | '\b' => '\0'
    | _ => ch

implement send_char (port, ch) =
  (* Remove characters we don't want (control characters, etc.) *)
  let
    val ch' = sanitise_output (port, ch)
  in
    (* Wait for UART to be ready. *)
    while ((inb (uint16_of (port.port + 5u)) land uint8_of 0x20u) = uint8_of 0u) ();
    outb (uint16_of port.port, ubyte_of (ch')) (* send! *)
  end

implement send_string (port, len, str) =
let
  var i: [i: Nat] int i
in
  for (i := 0; i < len; i := i + 1)
    send_char (port, str[i])
end
