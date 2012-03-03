// This defines fixed-width integer types.
// Warning: Architecture dependent!
staload "prelude/limits.sats"

stadef uint8 = ubyte
stadef uint16 = ushort
stadef uint32 = uint

overload uint8_of with ubyte_of_ubyte1
overload uint8_of with ubyte_of_ushort1
overload uint8_of with ubyte_of_uint1
overload uint8_of with ubyte_of_ulong1
overload uint8_of with ubyte_of_byte1
overload uint8_of with ubyte_of_short1
overload uint8_of with ubyte_of_int1
overload uint8_of with ubyte_of_long1
overload uint8_1_of with ubyte1_of_ubyte
overload uint8_1_of with ubyte1_of_ushort1
overload uint8_1_of with ubyte1_of_uint1
overload uint8_1_of with ubyte1_of_ulong1
overload uint8_1_of with ubyte1_of_byte1
overload uint8_1_of with ubyte1_of_short1
overload uint8_1_of with ubyte1_of_int1
overload uint8_1_of with ubyte1_of_long1

overload uint16_of with ushort_of_ubyte1
overload uint16_of with ushort_of_ushort1
overload uint16_of with ushort_of_uint1
overload uint16_of with ushort_of_ulong1
overload uint16_of with ushort_of_byte1
overload uint16_of with ushort_of_short1
overload uint16_of with ushort_of_int1
overload uint16_of with ushort_of_long1
overload uint16_1_of with ushort1_of_ubyte1
overload uint16_1_of with ushort1_of_ushort
overload uint16_1_of with ushort1_of_uint1
overload uint16_1_of with ushort1_of_ulong1
overload uint16_1_of with ushort1_of_byte1
overload uint16_1_of with ushort1_of_short1
overload uint16_1_of with ushort1_of_int1
overload uint16_1_of with ushort1_of_long1

overload uint32_of with uint_of_ubyte1
overload uint32_of with uint_of_ushort1
overload uint32_of with uint_of_uint1
overload uint32_of with uint_of_ulong1
overload uint32_of with uint_of_byte1
overload uint32_of with uint_of_short1
overload uint32_of with uint_of_int1
overload uint32_of with uint_of_long1
overload uint32_1_of with uint1_of_ubyte1
overload uint32_1_of with uint1_of_ushort1
overload uint32_1_of with uint1_of_uint
overload uint32_1_of with uint1_of_ulong1
overload uint32_1_of with uint1_of_byte1
overload uint32_1_of with uint1_of_short1
overload uint32_1_of with uint1_of_int1
overload uint32_1_of with uint1_of_long1
