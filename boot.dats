staload VGA = "vga-text.sats"
dynload "vga-text.dats"
dynload "serial.dats"
dynload "trace.dats"

extern fun ats_entry_point (): void = "ats_entry_point"
implement ats_entry_point () =
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

(*
  init_B8000 (view@ con | &con)


  val (fr_vram, pf_vram | vram) = get_vram ()
  var tty1: tmat = @{
    width = 80, height = 25,
    x = 0, y = 0,
    fr_vram = fr_vram, pf_vram = pf_vram,
    vram = vram
  }
in
  get_hw_cursor tty1;
  loop (tty1, 10) where {
    fun loop {w,h: Pos} {i: Nat} .<i>.
      (tty: &tmat1(w,h), i: int i): void =
    begin
      put_string (tty, 14, "Hello, world!\n");
      put_string (tty, 14, "AOentaohetnh!\n");
      put_string (tty, 14, "tnehaonethnh!\n");
      put_string (tty, 14, "Cbaogeohetnh!\n");
      put_string (tty, 14, "CGdc.gdeounh!\n");
      put_string (tty, 14, "Bmbwboetbunh!\n");
      put_string (tty, 14, ">PRgc,.bbeuh!\n");
      put_string (tty, 14, "EGOBJ ohetnh!\n");
      put_string (tty, 14, "!!!!!!!hetnh!\n");
      put_string (tty, 14, "???????hetnh!\n");
      if i > 0 then loop (tty, i-1)
    end
  };
  let prval () = eat_vram (tty1.fr_vram, tty1.pf_vram) in () end
end
*)
