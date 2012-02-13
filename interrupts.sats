(* Data structure created with the "pusha" instruction. *)
typedef pusha_struct =
  @{
    edi = uint32,
    esi = uint32,
    ebp = uint32,
    esp = uint32,
    ebx = uint32,
    edx = uint32,
    ecx = uint32,
    eax = uint32
  }

(* Structure that arises from an interrupt. *)
typedef interrupt_stack =
  @{
    (* from isr.S *)
    registers = pusha_struct,
    (* from CPU *)
    error_code = uint32,
    eip = uint32,
    cs = uint32,
    eflags = uint32,
    (* esp and ss are only present in a user->kernel switch *)
    esp = uint32,
    ss = uint32
  }

typedef interrupt_vector = [x: nat | x < 256] int x
typedef irq_interrupt_vector = [x: int | x >= 0x20 && x < 0x30] int x
typedef irq_number = [x: nat | x < 16] int x

(* Type of interrupt handler functions. Note that interrupt handlers
   and interrupt service routines (ISRs) are different.
   ISRs call the handlers. *)
typedef interrupt_handler =
  (interrupt_vector, &interrupt_stack) -<fun,!ntm,!ref> void
  (* XXX: !ref shouldn't be there! *)

fun init (): void
fun enable_interrupts_globally ():<> void = "mac#sti"
fun disable_interrupts_globally ():<> void = "mac#cli"
fun set_handler
  (vector: interrupt_vector,
   handler: interrupt_handler):<!ref> void
fun clear_handler (vector: interrupt_vector):<!ref> void

fun vector_of_irq (irq: irq_number):<> irq_interrupt_vector
fun irq_of_vector (vector: irq_interrupt_vector):<> irq_number

fun unmask_irq (irq: irq_number):<> void (* unmask (enable) IRQ *)
fun mask_irq (irq: irq_number):<> void   (* mask (disable) IRQ *)
fun ack_irq (irq: irq_number):<> void    (* acknowledge IRQ n *)

%{#
  #define sti() do { __asm__ volatile ("sti"); } while (0)
  #define cli() do { __asm__ volatile ("cli"); } while (0)
%}
