staload "trace.sats"
staload "serial.sats"
staload "enablable.sats"
staload "enablable.dats"

var com1: enablable serial_port = empty<serial_port> ()
val (pfcom1 | ()): ([l:agz] vbox (enablable serial_port @ l) | void)
  = vbox_make_view_ptr (view@ com1 | &com1)

implement init_serial {com_number} (com_number, baud) =
let
  prval vbox pfcom1 = pfcom1
in
  if not com1.enabled then
    let prval () = opt_unnone com1.obj
    in
      com1.enabled := init (com1.obj, com_number, baud)
    end
end

implement trace_loc_msg {loc_len, msg_len} (loc, msg) =
let
  prval vbox pfcom1 = pfcom1
in
  if com1.enabled then
    let
      prval () = opt_unsome com1.obj
      val () = send_string (com1.obj, string_length loc, loc)
      val () = send_string (com1.obj, 2, ": ")
      val () = send_string (com1.obj, string_length msg, msg)
      prval () = opt_some com1.obj
    in
      ()
    end
end
