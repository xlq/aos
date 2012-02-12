staload "trace.sats"
staload "serial.sats"
staload "vga-text.sats"
staload "enablable.sats"
staload "enablable.dats"

var com1: enablable serial_port = empty<serial_port> ()
val (pfcom1 | ()): ([l:agz] vbox (enablable serial_port @ l) | void)
  = vbox_make_view_ptr (view@ com1 | &com1)

var con: enablable console = empty<console> ()
val (pfcon | ()): ([l:agz] vbox (enablable console @ l) | void)
  = vbox_make_view_ptr (view@ con | &con)

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

implement init_vga () =
let
  prval vbox pfcon = pfcon
in
  if not con.enabled then
    let prval () = opt_unnone con.obj
    in
      con.enabled := init_B8000 con.obj
    end
end

implement trace_loc_msg {loc_len, msg_len} (loc, msg) =
begin
  let prval vbox pfcom1 = pfcom1 in
    if com1.enabled then
      let
        prval () = opt_unsome com1.obj
        val () = send_string (com1.obj, string_length loc, loc)
        val () = send_string (com1.obj, 2, ": ")
        val () = send_string (com1.obj, string_length msg, msg)
        prval () = opt_some com1.obj
      in () end
  end;
  let prval vbox pfcon = pfcon in
    if con.enabled then
      let
        prval () = opt_unsome con.obj
        val () = put_string (con.obj, string_length msg, msg)
        prval () = opt_some con.obj
      in () end
  end
end

implement panic_loc_msg {loc_len, msg_len} (loc, msg) =
begin
  let prval vbox pfcom1 = pfcom1 in
    if com1.enabled then
      let
        prval () = opt_unsome com1.obj
        val () = send_string (com1.obj, string_length loc, loc)
        val () = send_string (com1.obj, 23, ":\n*** KERNEL PANIC ***\n")
        val () = send_string (com1.obj, string_length msg, msg)
        prval () = opt_some com1.obj
      in () end
  end;
  let prval vbox pfcon = pfcon in
    if con.enabled then
      let
        prval () = opt_unsome con.obj
        val () = put_string (con.obj, 21, "*** KERNEL PANIC ***\n")
        val () = put_string (con.obj, string_length msg, msg)
        prval () = opt_some con.obj
      in () end
  end;
  halt_completely ()
end
