staload "gdt.sats"
staload "trace.sats"

(* Fill the GDT with the fixed entries. *)
fn fill_gdt
  {len: int | len >= 6}
  (gdt: &(@[gdt_entry][len]),
   tss_ptr: ptr): void =
let
  fn u {x: Uint16} (x: int x):<> uint16 = uint16_of (uint1_of x)
  fn up {x: Uint16} (x: uintptr_t x):<> uint16 = uint16_of (uint1_of x)
  val tss_ptr' = uintptr1_of tss_ptr
  (* Calculate TSS descriptor words by splitting TSS pointer into pieces. *)
  (* See CPU manuals for more information. *)
  val tssd1 = up (tss_ptr' land (uintptr1_of 0xFFFFu))
  val tssd2 = up ((tss_ptr' >> 16) land uintptr1_of 0x00FFu) lor u 0x8900
  val tssd3 = up ((tss_ptr' >> 16) land uintptr1_of 0xFF00u) lor u 0x0000
in
  gdt.[0] := (u 0, u 0, u 0, u 0); (* Dummy entry (the CPU doesn't use gdt[0]) *)
  gdt.[1] := (u 0xFFFF, u 0x0000, u 0x9A00, u 0x00CF); (* SEG_DPL0_CODE *)
  gdt.[2] := (u 0xFFFF, u 0x0000, u 0x9200, u 0x00CF); (* SEG_DPL0_DATA *)
  gdt.[3] := (u 0xFFFF, u 0x0000, u 0xFA00, u 0x00CF); (* SEG_DPL3_CODE *)
  gdt.[4] := (u 0xFFFF, u 0x0000, u 0xF200, u 0x00CF); (* SEG_DPL3_DATA *)
  gdt.[5] := (u 0x0068, tssd1, tssd2, tssd3); (* TSS descriptor *) // u 0x89AA, u 0xAA00); (* TSS descriptor *)
  ()
end

%{^
  extern char stack_bottom[];
  #define get_stack_bottom() ((uint32_t) stack_bottom)
%}
extern fun get_stack_bottom (): uint32 = "mac#get_stack_bottom"

(* The default task state segment. *)
local
  fn s {x: Uint16} (x: int x):<> uint16 = uint16_of (uint1_of x)
  fn i {x: Uint32} (x: int x):<> uint32 = uint32_of (uint1_of x)
in
  var tss0: tss =
    @{ 
      prev   = s 0, res0   = s 0, esp0   = get_stack_bottom (),
      ss0    = s SEG_DPL0_DATA,
                    res1   = s 0, esp1   = i 0,
      ss1    = s 0, res2   = s 0, esp2   = i 0,
      ss2    = s 0, res3   = s 0, cr3    = i 0,
      eip    = i 0, eflags = i 0,
      eax    = i 0, ecx    = i 0,
      edx    = i 0, ebx    = i 0,
      esp    = i 0, ebp    = i 0,
      esi    = i 0, edi    = i 0,
      es     = s 0, res4   = s 0,
      cs     = s 0, res5   = s 0,
      ss     = s 0, res6   = s 0,
      ds     = s 0, res7   = s 0,
      fs     = s 0, res8   = s 0,
      gs     = s 0, res9   = s 0,
      ldt    = s 0, res10  = s 0,
      debug_trap = s 0,
      iomap_base = s 0
    }
end

(* The default GDT. *)
%{^
  static uint16_t the_gdt [4*6];
  #define get_the_gdt() (the_gdt)
%}
extern fun the_gdt ():
  [l: agz] (@[gdt_entry][6] @ l | ptr l) = "mac#get_the_gdt"
(* XXX: Should be [gdt_entry?] *)


%{^
  /* Load the GDT register with the address and size of the GDT. */
  static void lgdt (void *address, size_t size)
  {
    __asm__ __volatile__ (
      "subl $6,%%esp         \n"
      "movw %%cx,(%%esp)     \n"
      "movl %%eax,2(%%esp)   \n"
      "lgdt (%%esp)          \n"
      "addl $6,%%esp         \n"
      :: "c" (size), "a" (address)
      : "cc"
    );
  }

  /* Load data segment registers. */
  static void load_data_segregs (int data_seg_sel)
  {
    __asm__ __volatile__ (
      "movw %%ax,%%ds \n"
      "movw %%ax,%%es \n"
      "movw %%ax,%%fs \n"
      "movw %%ax,%%gs \n"
      :: "a" (data_seg_sel)
    );
  }

  /* Load stack segment register. */
  static void load_ss (int data_seg_sel)
  {
    __asm__ __volatile__ (
      "movw %%ax,%%ss \n"
      :: "a" (data_seg_sel)
    );
  }

  /* Load the code segment register. */
  static void load_cs (int code_seg_sel)
  {
    __asm__ __volatile__ (
      "pushf        \n"  /* eflags */
      "pushl %%eax  \n"  /* cs */
      "pushl $1f    \n"  /* eip */
      "iret         \n"
      "1:           \n"
      :: "a" (code_seg_sel)
    );
  }

  /* Load the task register. */
  static void ltr (int tss_seg_sel)
  {
    __asm__ __volatile__ (
      "ltr %%ax"
      :: "a" (tss_seg_sel)
    );
  }
%}

extern fun lgdt
  {l: agz} {len: nat}
  (pf: @[gdt_entry][len] @ l |
   address: ptr l,
   size: size_t (len * sizeof gdt_entry)):<> void
  = "lgdt"

extern fun load_data_segregs
  {x: Uint16} (data_seg_sel: int x):<> void
  = "load_data_segregs"

extern fun load_ss
  {x: Uint16} (data_seg_sel: int x):<> void
  = "load_ss"

extern fun load_cs
  {x: Uint16} (code_seg_sel: int x):<> void
  = "load_cs"

extern fun ltr
  {x: Uint16} (task_seg_sel: int x):<> void
  = "ltr"

implement init () =
  if sizeof<gdt_entry> != size1_of 8 then begin
    panicloc ("sizeof<gdt_entry> is not 8.")
  end else let
    val [l: addr] (pf_gdt | gdt) = the_gdt ()
    val () = fill_gdt (!gdt, &tss0)
  in
    trace "LGDT ";
    lgdt {l} {6} (pf_gdt | gdt,
      size1_of_int1 (6 * int1_of sizeof<gdt_entry>));

    (* Re-load all the data segment registers.
       We can use the ring 3 segments, then we don't have to keep
       switching. This is not a problem, because we're not using
       segmentation as a means of protection. *)
    trace "DS "; load_data_segregs SEG_DPL3_DATA;
    trace "SS "; load_ss SEG_DPL0_DATA;
    trace "CS "; load_cs SEG_DPL0_CODE;
    trace "LTR "; ltr SEG_DPL3_TSS
  end
