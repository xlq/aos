staload "portio.sats"

implement io_wait () =
let
  var i: Int
in
  for* {i: nat | i <= 16} .<16-i>. (i: int i)
  => (i := 0; i < 16; i := i + 1)
    outb (uint16_of 0x80u, uint8_of 0u)
end

