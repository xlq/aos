staload "integers.sats"

implement uint8_of (x) = uintx_of (uint8 | uint1_of_int x)
implement uint16_of (x) = uintx_of (uint16 | uint1_of_int x)
implement uint32_of (x) = uintx_of (uint32 | uint1_of_int x)
