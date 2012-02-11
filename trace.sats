staload "prelude/limits.sats"

fun init_serial
  {com_number: int | com_number >= 1 && com_number <= 4}
  {baud: pos}
  (com_number: int com_number,
   baud: uint baud):<!ref> void

fun trace_loc_msg {loc_len, msg_len: nat}
  (loc: string loc_len, msg: string msg_len): void

macdef traceloc (msg) = trace_loc_msg (string1_of_string #LOCATION, ,(msg))
