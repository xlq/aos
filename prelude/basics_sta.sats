(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
** Copyright (C) 2002-2010 Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: 2007
// Edited in 2012 by Joshua Phillips
//
(* ****** ****** *)


(* Mandatory, "pervasive" declarations required by compiler. *)

abst@ype void_t0ype = $extype "ats_void_type"

abst@ype bool_t0ype = $extype "bool"
abst@ype char_t0ype = $extype "char"
abst@ype byte_t0ype = $extype "schar"
abst@ype ubyte_t0ype = $extype "uchar"
abst@ype int_t0ype = $extype "int"
abst@ype uint_t0ype = $extype "uint"
abst@ype int_short_t0ype = $extype "short"
abst@ype uint_short_t0ype = $extype "ushort"
abst@ype int_long_t0ype = $extype "long"
abst@ype uint_long_t0ype = $extype "ulong"
abst@ype int_llong_t0ype = $extype "llong"
abst@ype uint_llong_t0ype = $extype "ullong"
abst@ype size_t0ype = $extype "size_t"
abst@ype ssize_t0ype = $extype "ssize_t"
abst@ype intptr_t0ype = $extype "intptr_t"
abst@ype uintptr_t0ype = $extype "uintptr_t"
abstype ptr_type = $extype "ptr"

abst@ype bool_bool_t0ype (bool) = bool_t0ype
abst@ype char_char_t0ype (char) = char_t0ype
abst@ype byte_int_t0ype (int) = byte_t0ype
abst@ype ubyte_int_t0ype (int) = ubyte_t0ype
abst@ype int_int_t0ype (int) = int_t0ype
abst@ype uint_int_t0ype (int) = uint_t0ype
abst@ype int_short_int_t0ype (int) = int_short_t0ype
abst@ype uint_short_int_t0ype (int) = uint_short_t0ype
abst@ype lint_int_t0ype (int) = int_long_t0ype
abst@ype ulint_int_t0ype (int) = uint_long_t0ype
abst@ype int_llong_int_t0ype (int) = int_llong_t0ype
abst@ype uint_llong_int_t0ype (int) = uint_llong_t0ype
abst@ype size_int_t0ype (int) = size_t0ype
abst@ype ssize_int_t0ype (int) = ssize_t0ype
abst@ype intptr_int_t0ype (int) = intptr_t0ype
abst@ype uintptr_int_t0ype (int) = uintptr_t0ype
abst@ype ptr_addr_type (addr) = ptr_type

abstype string_type
abstype string_int_type (int)
abst@ype strbuf_t0ype
abst@ype strbuf_int_int_t0ype (int, int)

absviewt@ype clo_viewt0ype_viewt0ype (viewt@ype+)
absviewtype cloptr_viewt0ype_viewtype (viewt@ype+)
abstype cloref_t0ype_type (t@ype)
absviewt@ype crypt_viewt0ype_viewt0ype (a: viewt@ype) = a

absview at_viewt0ype_addr_view (viewt@ype+, addr)
absprop vbox_view_prop (view)

stacst true_bool : bool and false_bool : bool
stacst neg_bool_bool : bool -> bool (* boolean negation *)
stacst mul_bool_bool_bool : (bool, bool) -> bool (* conjunction *)
stacst add_bool_bool_bool : (bool, bool) -> bool (* disjunction *)
stacst gt_bool_bool_bool : (bool, bool) -> bool
stacst gte_bool_bool_bool : (bool, bool) -> bool
stacst lt_bool_bool_bool : (bool, bool) -> bool
stacst lte_bool_bool_bool : (bool, bool) -> bool
stacst eq_bool_bool_bool : (bool, bool) -> bool
stacst neq_bool_bool_bool : (bool, bool) -> bool

stacst sub_char_char_int : (char, char) -> int
stacst gt_char_char_bool : (char, char) -> bool
stacst gte_char_char_bool : (char, char) -> bool
stacst lt_char_char_bool : (char, char) -> bool
stacst lte_char_char_bool : (char, char) -> bool
stacst eq_char_char_bool : (char, char) -> bool
stacst neq_char_char_bool : (char, char) -> bool

stacst neg_int_int : int -> int (* integer negation *)
stacst add_int_int_int : (int, int) -> int (* addition *)
stacst sub_int_int_int: (int, int) -> int (* subtraction *)
stacst nsub_int_int_int: (int, int) -> int (* subtraction on nats *)
stacst mul_int_int_int : (int, int) -> int (* multiplication *)
stacst div_int_int_int : (int, int) -> int (* division *)
stadef / = div_int_int_int
stacst gt_int_int_bool : (int, int) -> bool
stacst gte_int_int_bool : (int, int) -> bool
stacst lt_int_int_bool : (int, int) -> bool
stacst lte_int_int_bool : (int, int) -> bool
stacst eq_int_int_bool : (int, int) -> bool
stacst neq_int_int_bool : (int, int) -> bool

stacst null_addr : addr
stacst add_addr_int_addr : (addr, int) -> addr
stacst sub_addr_int_addr : (addr, int) -> addr
stacst sub_addr_addr_int : (addr, addr) -> int
stacst gt_addr_addr_bool : (addr, addr) -> bool
stacst gte_addr_addr_bool : (addr, addr) -> bool
stacst lt_addr_addr_bool : (addr, addr) -> bool
stacst lte_addr_addr_bool : (addr, addr) -> bool
stacst eq_addr_addr_bool : (addr, addr) -> bool
stacst neq_addr_addr_bool : (addr, addr) -> bool

stacst lte_cls_cls_bool : (cls, cls) -> bool

(* Short names. *)
stadef void = void_t0ype
stadef bool = bool_t0ype
stadef char = char_t0ype
stadef byte = byte_t0ype
stadef ubyte = ubyte_t0ype
stadef int = int_t0ype
stadef uint = uint_t0ype
stadef short = int_short_t0ype
stadef ushort = uint_short_t0ype
stadef long = int_long_t0ype
stadef ulong = uint_long_t0ype
stadef llong = int_llong_t0ype
stadef ullong = uint_llong_t0ype
stadef size_t = size_t0ype
stadef ssize_t = ssize_t0ype
stadef intptr_t = intptr_t0ype
stadef uintptr_t = uintptr_t0ype
stadef ptr = ptr_type
stadef bool = bool_bool_t0ype
stadef char = char_char_t0ype
stadef byte = byte_int_t0ype
stadef ubyte = ubyte_int_t0ype
stadef int = int_int_t0ype
stadef uint = uint_int_t0ype
stadef short = int_short_int_t0ype
stadef ushort = uint_short_int_t0ype
stadef long = lint_int_t0ype
stadef ulong = ulint_int_t0ype
stadef llong = int_llong_int_t0ype
stadef ullong = uint_llong_int_t0ype
stadef size_t = size_int_t0ype
stadef ssize_t = ssize_int_t0ype
stadef uintptr_t = uintptr_int_t0ype
stadef ptr = ptr_addr_type
stadef string = string_type
stadef string = string_int_type

stadef @ = at_viewt0ype_addr_view
stadef vbox = vbox_view_prop

stadef true = true_bool and false = false_bool
stadef ~ = neg_bool_bool
stadef && = mul_bool_bool_bool
stadef || = add_bool_bool_bool
stadef > = gt_bool_bool_bool
stadef >= = gte_bool_bool_bool
stadef < = lt_bool_bool_bool
stadef <= = lte_bool_bool_bool
stadef == = eq_bool_bool_bool
stadef <> = neq_bool_bool_bool

stadef - = sub_char_char_int
stadef > = gt_char_char_bool
stadef >= = gte_char_char_bool
stadef < = lt_char_char_bool
stadef <= = lte_char_char_bool
stadef == = eq_char_char_bool
stadef <> = neq_char_char_bool

stadef ~ = neg_int_int
stadef + = add_int_int_int
stadef - = sub_int_int_int
stadef nsub = nsub_int_int_int
stadef * = mul_int_int_int
stadef > = gt_int_int_bool
stadef >= = gte_int_int_bool
stadef < = lt_int_int_bool
stadef <= = lte_int_int_bool
stadef == = eq_int_int_bool
stadef <> = neq_int_int_bool

stadef + = add_addr_int_addr
stadef - = sub_addr_int_addr
stadef - = sub_addr_addr_int
stadef > = gt_addr_addr_bool
stadef >= = gte_addr_addr_bool
stadef < = lt_addr_addr_bool
stadef <= = lte_addr_addr_bool
stadef == = eq_addr_addr_bool
stadef <> = neq_addr_addr_bool

stadef null = null_addr

(* ****** ****** *)

// abst@ype uint8 = $extype "uint8_t"
// abst@ype uint16 = $extype "uint16_t"
// abst@ype uint32 = $extype "uint32_t"


(* ****** ****** *)
//
// HX: The following definitions are needed in the ATS constraint solver
//
// absolute value function relation
//
stadef abs_int_int_bool (x: int, v: int): bool =
  (x >= 0 && x == v) || (x <= 0 && ~x == v)
stadef abs_r = abs_int_int_bool
//
// HX: in-between relation
//
stadef btw_int_int_int_bool (x: int, y: int, z:int): bool =
  (x <= y && y < z)
//
// HX: int_of_bool conversion
//
stadef int_of_bool_bool (b: bool, v: int): bool =
  (b && v == 1) || (~b && v == 0)
//
// HX: subtraction relation on natural numbers
//
stadef nsub_int_int_int_bool (x: int, y: int, v: int): bool =
  (x >= y && v == x - y) || (x <= y && v == 0)
stadef nsub_r = nsub_int_int_int_bool
//
// HX: maximum function relation
//
stadef max_int_int_int_bool (x: int, y: int, v: int): bool =
  (x >= y && x == v) || (x <= y && y == v)
stadef max_r = max_int_int_int_bool
//
// HX: minimum function relation
//
stadef min_int_int_int_bool (x: int, y: int, v: int): bool =
  (x >= y && y == v) || (x <= y && x == v)
stadef min_r = min_int_int_int_bool
//
// HX: sign function relation
//
stadef sgn_int_int_bool (x: int, v: int): bool =
  (x > 0 && v == 1) || (x == 0 && v == 0) || (x < 0 && v == ~1)
stadef sgn_r = sgn_int_int_bool
//
// HX: division relation (nat)
//
stadef ndiv_int_int_int_bool (x: int, y: int, q: int): bool =
  (q * y <= x && x < q * y + y)
stadef ndiv_r = ndiv_int_int_int_bool
//
// HX: division relation (int)
//
stadef div_int_int_int_bool (x: int, y: int, q: int) =
  (x >= 0 && y > 0 && ndiv_int_int_int_bool (x, y, q)) ||
  (x >= 0 && y < 0 && ndiv_int_int_int_bool (x, ~y, ~q)) ||
  (x <= 0 && y > 0 && ndiv_int_int_int_bool (~x, y, ~q)) ||
  (x <= 0 && y < 0 && ndiv_int_int_int_bool (~x, ~y, q))
stadef div_r = div_int_int_int_bool
//
// HX: modulo relation // not handled yet
//
(* ****** ****** *)

stadef
size_int_int_bool
  (sz:int, n:int) = n >= 0
stacst sizeof_viewt0ype_int : viewt@ype -> int
stadef sizeof = sizeof_viewt0ype_int

(**********  Views/helpful types/etc.  **********)

absviewt@ype opt (vt:viewt@ype+, opt:bool) = vt

prfun static_assert {b: bool | b == true} (): void // = ()

dataview choice_v (b:bool, true_v:view+, false_v:view+) =
  | True_v (true, true_v, false_v) of true_v
  | False_v (false, true_v, false_v) of false_v

dataview option_v (v:view+, b:bool) =
  | Some_v (v, true) of v
  | None_v (v, false)

dataviewtype option_vt (v:viewt@ype+, b:bool) =
  | Some_vt (v, true) of v
  | None_vt (v, false)

prfun check {b: bool | b == true} (): void (* = () *)
