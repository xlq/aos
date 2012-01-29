staload "prelude/limits.sats"

fun trace_loc_msg {loc_len, msg_len: Nat}
  (loc: string loc_len, msg: string msg_len): void

macdef traceloc (msg) = trace_loc_msg (#LOCATION, ,(msg))
