(* This defines architecture-dependent limits for integer types. **)

(*
stadef INT_MAX = 0x7FFFFFFF
stadef INT_MIN = ~0x80000000
*)

(* These are low for testing purposes! *)
#define INT_MAX 0x7FFF
#define INT_MIN (~0x8000)

#define UINT8_MIN 0
#define UINT8_MAX 0xFF

sortdef Int = {a: int | a >= INT_MIN && a <= INT_MAX}
sortdef Nat = {a: Int | a >= 0}
sortdef Pos = {a: Int | a > 0}
sortdef Uint8 = {a: int | a >= UINT8_MIN && a <= UINT8_MAX}

typedef Int = [i: Int] int i
typedef Nat = [i: Nat] int i
