(* This defines architecture-dependent limits for integer types. **)

(*
stadef INT_MAX = 0x7FFFFFFF
stadef INT_MIN = ~0x80000000
*)

#define INT_MAX 0x7FFFFFFF
#define INT_MIN (~0x80000000)
#define UINT_MAX 0xFFFFFFFF
#define UINT_MIN 0
#define INT_BIT 16
#define UINT_BIT 16

#define UINT8_MIN 0
#define UINT16_MIN 0
#define UINT32_MIN 0
#define UINT8_MAX 0xFF
#define UINT16_MAX 0xFFFF
#define UINT32_MAX 0xFFFFFFFF


sortdef Int = {a: int | a >= INT_MIN && a <= INT_MAX}
sortdef Nat = {a: Int | a >= 0}
sortdef Pos = {a: Int | a > 0}
sortdef Uint = {a: int | a >= UINT_MIN && a <= UINT_MAX}
sortdef Uint8 = {a: int | a >= UINT8_MIN && a <= UINT8_MAX}
sortdef Uint16 = {a: int | a >= UINT16_MIN && a <= UINT16_MAX}
sortdef Uint32 = {a: int | a >= UINT32_MIN && a <= UINT32_MAX}

typedef Int = [i: Int] int i
typedef Nat = [i: Nat] int i
typedef Pos = [i: Pos] int i
