
(* Segment selectors - these correspond to
   entries in the GDT. *)
#define SEG_DPL0_CODE 0x08   (* Kernel-level code *)
#define SEG_DPL0_DATA 0x10   (* Kernel-level data *)
#define SEG_DPL3_CODE 0x1B   (* User-level code *)
#define SEG_DPL3_DATA 0x23   (* User-level data *)
#define SEG_DPL3_TSS  0x2B   (* User-level TSS *)

(* The structure of the task state segment. *)
typedef tss =
@{
    prev   = uint16, res0   = uint16, esp0   = uint32,
    ss0    = uint16, res1   = uint16, esp1   = uint32,
    ss1    = uint16, res2   = uint16, esp2   = uint32,
    ss2    = uint16, res3   = uint16, cr3    = uint32,
    eip    = uint32, eflags = uint32,
    eax    = uint32, ecx    = uint32,
    edx    = uint32, ebx    = uint32,
    esp    = uint32, ebp    = uint32,
    esi    = uint32, edi    = uint32,
    es     = uint16, res4   = uint16,
    cs     = uint16, res5   = uint16,
    ss     = uint16, res6   = uint16,
    ds     = uint16, res7   = uint16,
    fs     = uint16, res8   = uint16,
    gs     = uint16, res9   = uint16,
    ldt    = uint16, res10  = uint16,
    debug_trap = uint16,
    iomap_base = uint16
  }

typedef gdt_entry = @( uint16, uint16, uint16, uint16 )

fun init (): void

