staload "integers.sats"
staload "serial.sats"
staload "portio.sats"

typedef port_t = [x: nat | x + 8 < 0x10000] uint16 x

assume serial_port (initialised: bool) =
  @{
    initialised = bool initialised,
    port = port_t,
    irq = int
  }

implement new = @{ initialised = false, port = uint16_of 0, irq = 0 }

implement is_initialised (port) = port.initialised

val COM1_IRQ = 4
val COM2_IRQ = 3
val COM1_BASE = uint16_of 0x3F8
val COM2_BASE = uint16_of 0x2F8
val COM3_BASE = uint16_of 0x3E8
val COM4_BASE = uint16_of 0x2E8

fn hang (): void = while (true) ()

(* Is a UART present? *)
fn detect_uart (port: &serial_port false): bool =
  let
    val tmp = inb (port.port + 4)
  in
    outb (port.port + 4, uint8_of 0x10);
    if (inb (port.port + 6) land 0xF0) > 0 then begin
      false
    end else begin
      outb (port.port + 4, uint8_of 0x1F);
      if (inb (port.port + 6) land 0xF0)
        != uint8_of 0xF0 then false
      else begin
        (* restore tmp *)
        outb (port.port + 4, tmp);
        true
      end
    end
  end

implement init (port, com_number, baud) =
  begin
    begin
      (* Select port base and IRQ number. *)
      case+ com_number of
        | 1 => (port.port := COM1_BASE; port.irq := COM1_IRQ)
        | 2 => (port.port := COM2_BASE; port.irq := COM2_IRQ)
        | 3 => (port.port := COM3_BASE; port.irq := COM1_IRQ)
        | 4 => (port.port := COM4_BASE; port.irq := COM2_IRQ)
    end;
    if not (detect_uart (port)) then false
    else let
      val divisor = int1_of_int (115200 / baud)
    in
      if (divisor < 0) || (divisor >= 0x10000) then false (* should never happen *)
      else begin
        outb (port.port + 1, uint8_of 0x00); // disable all interrupts
        outb (port.port + 3, uint8_of 0x80); // enable 'DLAB' - baud rate divisor
        outb (port.port + 0, (uint8_of 0xFF) land uint16_of divisor); // divisor (lower)
        outb (port.port + 1, (uint8_of 0xFF) land (divisor / 0x100)); // divisor (upper)
        outb (port.port + 3, uint8_of 0x03); // 8 bits, no parity, one stop bit
        outb (port.port + 2, uint8_of 0xC7); // enable FIFO, clear them, with 14 byte threshold
        outb (port.port + 4, uint8_of 0x0B); // enable something?
        outb (port.port + 4, inb (port.port + 4) lor uint8_of 8); // set OUT2 bit to enable interrupts
        outb (port.port + 1, uint8_of 0x01); // enable ERBFI (receiver buffer full interrupt)
        port.initialised := true;
        true
      end
    end
  end

fn sanitise_output (port: &serial_port true, ch: char): char =
  case+ ch of
    | '\n' => (send_char (port, '\r'); '\n') (* LF -> CRLF *)
    | '\b' => '\0'
    | _ => ch

implement send_char (port, ch) =
  (* Remove characters we don't want (control characters, etc.) *)
  let
    val ch' = sanitise_output (port, ch)
    val ch'' = int1_of_int (int_of_char ch')
  in
    if ch'' > 0 && ch'' < 256 then begin
      (* Wait for UART to be ready. *)
      while ((inb (port.port + 5) land 0x20) = 0) ();
      outb (port.port, uint8_of (ch'')) (* send! *)
    end
  end
