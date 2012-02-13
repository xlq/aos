(* Functions for printing messages for debugging.
   The messages are output to the display and serial port. *)

staload "prelude/limits.sats"

fun init_serial
  {com_number: int | com_number >= 1 && com_number <= 4}
  {baud: pos}
  (com_number: int com_number,
   baud: uint baud):<!ref> void

fun init_vga ():<!ref> void

fun trace (msg: string):<!ntm,!ref> void

fun trace_loc_msg
  (loc: string, msg: string):<!ntm,!ref> void

macdef traceloc (msg) = trace_loc_msg (#LOCATION, ,(msg))

fun halt_completely ():<!ntm> void
  = "halt_completely"

fun panic_loc_msg
  (loc: string, msg: string):<!ntm,!ref> void

macdef panicloc (msg) = panic_loc_msg (#LOCATION, ,(msg))

%{#
  static inline void halt_completely (void)
  {
    while (1){
      __asm__ volatile ("cli ; hlt");
    }
  }
%}
