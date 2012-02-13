staload "trace.sats"
staload GDT = "gdt.sats"
staload INT = "interrupts.sats"
dynload "vga-text.dats"
dynload "serial.dats"
dynload "trace.dats"
dynload "enablable.dats"
dynload "gdt.dats"
dynload "interrupts.dats"

extern fun ats_entry_point (): void = "ats_entry_point"
implement ats_entry_point () =
begin
  init_serial (1, 115200u);
  init_vga ();
  traceloc "Hello, world!\n";
  $GDT.init ();
  $INT.init ();
  $INT.enable_interrupts_globally ();
  $INT.unmask_irq (0);
  while (true) ();
  traceloc "\nHalting.\n"
end
