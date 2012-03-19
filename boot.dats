staload "trace.sats"
staload "portio.sats"
staload GDT = "gdt.sats"
staload INT = "interrupts.sats"
staload "bitflags.sats"
staload "multiboot.sats"
staload BS = "bounded_strings.sats"
staload "streams.sats"
dynload "prelude/DATS/integer.dats"
dynload "prelude/DATS/arith.dats"
dynload "prelude/DATS/array.dats"
dynload "bitflags.dats"
dynload "vga-text.dats"
dynload "portio.dats"
dynload "serial.dats"
dynload "trace.dats"
dynload "enablable.dats"
dynload "gdt.dats"
dynload "interrupts.dats"
dynload "bounded_strings.dats"
dynload "streams.dats"

extern fun ats_entry_point
  {l: agz}
  (pf_mb_info: !(mb_info @ l) |
   magic: uint32, mb_info: ptr l): void
  = "ats_entry_point"

fn play_with_strings (): void =
let
  var !s_buf with pf_s_buf = @[char][256] ('\0')
  var s = $BS.create (pf_s_buf | s_buf, 256)
  var c = $BS.stream (view@ s | &s)
  val () = put (HEX | c, 123)
  prval () = view@ s := $BS.unstream c
  val () = pf_s_buf := ($BS.destroy s).0
in () end

implement ats_entry_point (pf_mb_info | magic, mb_info) =
let
  var i: [i: Int] int i
  extern castfn uint_of_ptr1 (p: [l: addr] ptr l):<> uint
  extern castfn uint_of_type {t:type} (x: !t):<> uint
  extern castfn uint_of_size1 (x: [x: int] size_t x):<> uint
  extern castfn string_of_uint (x: uint):<> string
in
  // Give UART time to catch up:
  for (i := 0; i < 1000; i := i + 1) io_wait ();
  init_serial (1, 115200u);
  // init_vga ();
  trace "Hello, world!\n";
  play_with_strings ();
  trace "mb size: 0x";
  dump_uint (uint_of_size1 sizeof<mb_info>);
  trace "\nBoot magic: 0x";
  dump_uint magic;
  trace "\nmb_info is at 0x";
  dump_uint (uint_of_ptr1 mb_info);
  trace "\nBoot loader flags are 0x";
  dump_uint mb_info->flags;
  trace "\nmem_lower: 0x";
  dump_uint mb_info->mem_lower;
  trace "\nmem_upper: 0x";
  dump_uint mb_info->mem_upper;
  trace "\ncmd_line: 0x";
  dump_uint mb_info->cmd_line;
  trace " ";
  trace (string_of_uint (mb_info->cmd_line));
  trace "\n";
  if test_bit (mb_info->flags, MBI_BOOT_LOADER_NAME) then
    let
      prval () = opt_unsome mb_info->boot_loader_name
      val () = trace "Boot loader name is at 0x"
      val () = dump_uint (uint_of_type (mb_info->boot_loader_name));
      val () = trace "\nBoot loader name: "
      val () = trace mb_info->boot_loader_name
      val () = trace "\n";
      prval () = opt_some mb_info->boot_loader_name
    in end;
  $GDT.init ();
  $INT.init ();
  $INT.enable_interrupts_globally ();
  $INT.unmask_irq (0);
  while (true) ();
  traceloc "\nHalting.\n"
end
