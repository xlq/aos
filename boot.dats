staload VGA = "vga-text.sats"
staload Trace = "trace.sats"
dynload "vga-text.dats"
dynload "serial.dats"
dynload "trace.dats"
dynload "enablable.dats"

extern fun ats_entry_point (): void = "ats_entry_point"
implement ats_entry_point () =
(*
let
  var con: $VGA.console?
  val (pfcon | success) = $VGA.init_B8000 (view@ con | &con)
in
  if success then
    (* Success. *)
    let prval True_v pfcon = pfcon in
      view@ con := pfcon;
      $VGA.put (con, 43,
        "Hello, world! This is the kernel speaking.\n");
      $VGA.set_colour (con, $VGA.bright_green);
      $VGA.put (con, 15, "Coloured text!\n");
      $VGA.finit con
    end
  else
    (* Failed. *)
    let prval False_v pfcon = pfcon in
      view@ con := pfcon
    end
end
*)

begin
  $Trace.init_serial (1, 115200u);
  $Trace.init_vga ();
  $Trace.traceloc ("Hello, world!\n")
end
