// This defines architecture-dependent limits for integer types.

#define CHAR_MIN (~0x80)
#define CHAR_MAX 0x7F
#define SHRT_MIN (~0x8000)
#define SHRT_MAX 0x7FFF
#define INT_MAX 0x7FFFFFFF
#define INT_MIN (~0x80000000)
#define LONG_MAX 0x7FFFFFFF
#define LONG_MIN (~0x80000000)
#define LLONG_MAX 0x7FFFFFFFFFFFFFFF
#define LLONG_MIN (~0x8000000000000000)

#define UCHAR_MIN 0
#define USHRT_MIN 0
#define UINT_MIN 0
#define ULONG_MIN 0
#define ULLONG_MIN 0

#define UCHAR_MAX 0xFF
#define USHRT_MAX 0xFFFF
#define UINT_MAX 0xFFFFFFFF
#define ULONG_MAX 0xFFFFFFFF
#define ULLONG_MAX 0xFFFFFFFFFFFFFFFF

#define INT_BIT 32
#define UINT_BIT 32

#define UINT8_MIN 0
#define UINT16_MIN 0
#define UINT32_MIN 0
#define UINT8_MAX 0xFF
#define UINT16_MAX 0xFFFF
#define UINT32_MAX 0xFFFFFFFF

#define UINTPTR_MIN 0
#define UINTPTR_MAX 0xFFFFFFFF

#define SIZE_MIN 0
#define SIZE_MAX 0xFFFFFFFF

sortdef Byte = {a: int | a >= CHAR_MIN && a <= CHAR_MAX}
sortdef Short = {a: int | a >= SHRT_MIN && a <= SHRT_MAX}
sortdef Int = {a: int | a >= INT_MIN && a <= INT_MAX}
sortdef Nat = {a: Int | a >= 0}
sortdef Pos = {a: Int | a > 0}
sortdef Long = {a: int | a >= LONG_MIN && a <= LONG_MAX}
sortdef Llong = {a: int | a >= LLONG_MIN && a <= LLONG_MAX}

sortdef Ubyte = {a: int | a >= UCHAR_MIN && a <= UCHAR_MAX}
sortdef Ushort = {a: int | a >= USHRT_MIN && a <= USHRT_MAX}
sortdef Uint = {a: nat | a >= UINT_MIN && a <= UINT_MAX}
sortdef Ulong = {a: int | a >= ULONG_MIN && a <= ULONG_MAX}
sortdef Ullong = {a: int | a >= ULLONG_MIN && a <= ULLONG_MAX}


sortdef Uint8 = {a: int | a >= UINT8_MIN && a <= UINT8_MAX}
sortdef Uint16 = {a: int | a >= UINT16_MIN && a <= UINT16_MAX}
sortdef Uint32 = {a: int | a >= UINT32_MIN && a <= UINT32_MAX}
sortdef Uintptr = {a: int | a >= UINTPTR_MIN && a <= UINTPTR_MAX}
sortdef Size = {a: int | a >= SIZE_MIN && a <= SIZE_MAX}

typedef Int = [i: Int] int i
typedef Nat = [i: Nat] int i
typedef Pos = [i: Pos] int i
