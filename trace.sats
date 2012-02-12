staload "prelude/limits.sats"

fun init_serial
  {com_number: int | com_number >= 1 && com_number <= 4}
  {baud: pos}
  (com_number: int com_number,
   baud: uint baud):<!ref> void

fun init_vga ():<!ref> void

fun trace_loc_msg {loc_len, msg_len: nat}
  (loc: string loc_len, msg: string msg_len):<!ntm,!ref> void

macdef traceloc (msg) = trace_loc_msg (string1_of_string #LOCATION, ,(msg))

fun halt_completely ():<!ntm> void
  = "halt_completely"

fun panic_loc_msg {loc_len, msg_len: nat}
  (loc: string loc_len, msg: string msg_len):<!ntm,!ref> void

macdef panicloc (msg) = panic_loc_msg (string1_of_string #LOCATION, ,(msg))

%{#
  static inline void halt_completely (void)
  {
    while (1){
      __asm__ __volatile__ ("cli ; hlt");
    }
  }
%}
