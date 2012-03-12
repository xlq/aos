staload "trace.sats"
staload "portio.sats"
staload GDT = "gdt.sats"
staload INT = "interrupts.sats"
staload "bitflags.sats"
staload "multiboot.sats"
dynload "prelude/DATS/integer.dats"
dynload "prelude/DATS/arith.dats"
dynload "bitflags.dats"
dynload "vga-text.dats"
dynload "portio.dats"
dynload "serial.dats"
dynload "trace.dats"
dynload "enablable.dats"
dynload "gdt.dats"
dynload "interrupts.dats"

extern fun ats_entry_point
  {l: agz}
  (pf_mb_info: !(mb_info @ l) |
   magic: uint32, mb_info: ptr l): void
  = "ats_entry_point"

fn pause (): void =
let var i: Int in
  for (i := 0; i < 10000; i := i + 1) io_wait ();
end

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
  pause ();
  trace "Hello, world!\n";
  pause ();
  trace "mb size: 0x";
  dump_uint (uint_of_size1 sizeof<mb_info>);
  trace "\nBoot magic: 0x";
  pause ();
  dump_uint magic;
  pause ();
  trace "\nmb_info is at 0x";
  pause ();
  dump_uint (uint_of_ptr1 mb_info);
  pause ();
  trace "\nBoot loader flags are 0x";
  pause ();
  dump_uint mb_info->flags;
  pause ();
  trace "\nmem_lower: 0x";
  dump_uint mb_info->mem_lower;
  trace "\nmem_upper: 0x";
  dump_uint mb_info->mem_upper;
  trace "\ncmd_line: 0x";
  dump_uint mb_info->cmd_line;
  trace " ";
  pause ();
  trace (string_of_uint (mb_info->cmd_line));
  trace "\n";
  pause ();
  if test_bit (mb_info->flags, MBI_BOOT_LOADER_NAME) then
    let
      prval () = opt_unsome mb_info->boot_loader_name
      val () = trace "Boot loader name is at 0x"
      val () = dump_uint (uint_of_type (mb_info->boot_loader_name));
      val () = trace "\nBoot loader name: "
      val () = pause ()
      val () = trace mb_info->boot_loader_name
      val () = pause ()
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
