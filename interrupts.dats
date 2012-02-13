staload "interrupts.sats"
staload "portio.sats"
staload GDT = "gdt.sats"
staload "trace.sats"

(* PIC registers *)
#define PIC1_CMD 0x20
#define PIC1_DATA 0x21
#define PIC2_CMD 0xA0
#define PIC2_DATA 0xA1

(* PIC commands *)
#define PIC_ACK 0x20
#define ICW1_ICW4 0x01
#define ICW1_SINGLE 0x02
#define ICW1_INTERVAL4 0x04
#define ICW1_LEVEL 0x08
#define ICW1_INIT 0x10
#define ICW4_8086 0x01
#define ICW4_AUTO 0x02
#define ICW4_BUF_SLAVE 0x08
#define ICW4_BUF_MASTER 0x0C
#define ICW4_SFNM 0x10

typedef interrupt_descriptor = @( uint16, uint16, uint16, uint16 )

%{^
  void(*interrupt_handlers[256])();
  struct { uint16_t a,b,c,d; } the_idt[256];
%}

val (pf_interrupt_handlers | interrupt_handlers) =
  $extval ([l: agz] (vbox (@[interrupt_handler][256] @ l) | ptr l),
           "interrupt_handlers")

val (pf_the_idt | the_idt) =
  $extval ([l: agz] (vbox (@[interrupt_descriptor][256] @ l) | ptr l),
           "the_idt")

fn default_interrupt_handler
  (vector: interrupt_vector,
   stack: &interrupt_stack):<!ntm,!ref> void =
begin
  trace "tick ";
  if vector >= 0x20 && vector < 0x30 then
    ack_irq (irq_of_vector vector)
end

%{^
  /* isr0 and isr1 point to code defined in isr.S. */
  extern char isr0[], isr1[];

  /* The interrupt service routines are evenly spaced.
     This macro obtains the address of the nth. */
  #define nth_isr(n) ((uintptr_t) (isr0 + (isr1 - isr0) * (n)))

  static void lidt (void *idt)
  {
    __asm__ volatile (
      "subl $6,%%esp         \n"
      "movw %%cx,(%%esp)     \n"
      "movl %%eax,2(%%esp)   \n"
      "lidt (%%esp)          \n"
      "addl $6,%%esp         \n"
      :: "c" (256*8), "a" (idt)
      : "cc"
    );
  }
%}

extern fun nth_isr {n: nat | n < 256}
  (n: int n):<> [x: Uintptr] uintptr_t x = "mac#nth_isr"

extern fun lidt {l: agz}
  (pf: !(@[interrupt_descriptor][256] @ l) |
   p: ptr l):<> void = "lidt"

fn io_wait ():<> void =
let
  var i: Int
in
  for* {i: nat | i <= 16} .<16-i>. (i: int i)
  => (i := 0; i < 16; i := i + 1)
    outb (uint16_of 0x80u, uint8_of 0u)
end

fn w {x: Uint16} (x: int x):<> uint16 = uint16_of (uint1_of x)
fn b {x: Uint8} (x: int x):<> uint8 = uint8_of (uint1_of x)

fn remap_pics ():<> void =
let
  val pic1_offset = 0x20
  val pic2_offset = 0x28
in
  outb (w PIC1_CMD, b (ICW1_INIT + ICW1_ICW4)); io_wait ();
  outb (w PIC2_CMD, b (ICW1_INIT + ICW1_ICW4)); io_wait ();
  outb (w PIC1_DATA, b pic1_offset); io_wait ();
  outb (w PIC2_DATA, b pic2_offset); io_wait ();
  outb (w PIC1_DATA, b 4); io_wait ();
  outb (w PIC2_DATA, b 2); io_wait ();
  outb (w PIC1_DATA, b ICW4_8086); io_wait ();
  outb (w PIC2_DATA, b ICW4_8086); io_wait ();
  outb (w PIC1_DATA, b 0xFF);
  outb (w PIC2_DATA, b 0xFF)
end

implement init () =
begin
  (* Fill in the IDT and handler table. *)
  let var i: Int in
    for* {i: nat | i <= 256} .<256-i>. (i: int i)
    => (i := 0; i < 256; i := i + 1)
    begin
      let prval vbox pf_the_idt = pf_the_idt in
        the_idt->[i] := @(
          uint16_of (uint1_of ((nth_isr i) land uintptr1_of 0xFFFFu)),
          w $GDT.SEG_DPL0_CODE,
          w 0x8E00,
          uint16_of (uint1_of (((nth_isr i) >> 16) land uintptr1_of 0xFFFFu))
        );
      end;
      let prval vbox pf_interrupt_handlers = pf_interrupt_handlers in
        interrupt_handlers->[i] := default_interrupt_handler
      end
    end
  end;
  trace "IDT ";
  let prval vbox pf_the_idt = pf_the_idt in
    lidt (pf_the_idt | the_idt)
  end;
  trace "PIC ";
  remap_pics ();
  (* Enable the cascade IRQ so that the slave PIC can work. *)
  unmask_irq 2
end

implement set_handler (vector, handler) =
let prval vbox pf_interrupt_handlers = pf_interrupt_handlers in
  interrupt_handlers->[vector] := handler
end

implement clear_handler (vector) =
let prval vbox pf_interrupt_handlers = pf_interrupt_handlers in
  interrupt_handlers->[vector] := default_interrupt_handler
end

implement vector_of_irq (irq) = irq + 0x20
implement irq_of_vector (vector) = vector - 0x20

prfn exple
  {x, n1, n2, y1, y2: nat | n1 <= n2}
  (pf1: SHL (x, n1, y1), pf2: SHL (x, n2, y2)):
  [y1 <= y2] void =
let
  prval (pf_exp1, pf_mul1) = pf1
  prval (pf_exp2, pf_mul2) = pf2
  prval () = EXP2_monotone (pf_exp1, pf_exp2)
  prval () = mul_nat_nat_nat (mul_distribute (mul_negate2 (pf_mul1), pf_mul2))
in () end

prval SHL_1_7: SHL (1, 7, 128) = (,(pf_exp2_const 7), MULind(MULbas()))

implement unmask_irq ([irq: int] irq) =
  if irq < 8 then begin
    (* Master PIC *)
    let
      val a = inb (w PIC1_DATA)
      prval pf_bit = SHL_make {1, irq} ()
      prval () = exple (pf_bit, SHL_1_7)
      val bit = ushl3 (pf_bit | 1u, irq)
      val a = a land ~ uint8_of bit
      val () = outb (w PIC1_DATA, a)
    in () end
  end else begin
    (* Slave PIC *)
    let
      val a = inb (w PIC2_DATA)
      prval pf_bit = SHL_make {1,irq-8} ()
      prval () = exple (pf_bit, SHL_1_7)
      val bit = ushl3 (pf_bit | 1u, irq-8)
      val a = a land ~ uint8_of bit
      val () = outb (w PIC2_DATA, a)
    in () end
  end

implement mask_irq ([irq: int] irq) =
  if irq < 8 then begin
    (* Master PIC *)
    let
      val a = inb (w PIC1_DATA)
      prval pf_bit = SHL_make {1, irq} ()
      prval () = exple (pf_bit, SHL_1_7)
      val bit = ushl3 (pf_bit | 1u, irq)
      val a = a lor uint8_of bit
      val () = outb (w PIC1_DATA, a)
    in () end
  end else begin
    (* Slave PIC *)
    let
      val a = inb (w PIC2_DATA)
      prval pf_bit = SHL_make {1,irq-8} ()
      prval () = exple (pf_bit, SHL_1_7)
      val bit = ushl3 (pf_bit | 1u, irq-8)
      val a = a lor uint8_of bit
      val () = outb (w PIC2_DATA, a)
    in () end
  end

implement ack_irq (n) =
begin
  if n >= 8 then outb (w PIC2_CMD, b PIC_ACK);
  outb (w PIC1_CMD, b PIC_ACK)
end
