(* x86 I/O port interface. *)

staload "integers.sats"

%{#
  static inline void outb(uint16_t port, uint8_t value)
  {
    asm volatile ("outb %%al,%%dx" :: "a" (value), "d" (port));
  }

  static inline void outw(uint16_t port, uint16_t value)
  {
    asm volatile ("outw %%ax,%%dx" :: "a" (value), "d" (port));
  }

  static inline void outl(uint16_t port, uint32_t value)
  {
    asm volatile ("outl %%eax,%%dx" :: "a" (value), "d" (port));
  }

  static inline uint8_t inb(uint16_t port)
  {
    uint8_t value;
    asm volatile ("inb %%dx,%%al" : "=a" (value) : "d" (port));
    return value;
  }

  static inline uint16_t inw(uint16_t port)
  {
    uint16_t value;
    asm volatile ("inw %%dx,%%ax" : "=a" (value) : "d" (port));
    return value;
  }

  static inline uint32_t inl(uint16_t port)
  {
    uint32_t value;
    asm volatile ("inl %%dx,%%eax" : "=a" (value) : "d" (port));
    return value;
  }
%}

fun inb (port: uint16): uint8 = "mac#inb"
fun inw (port: uint16): uint16 = "mac#inw"
fun inl (port: uint16): uint32 = "mac#inl"
fun outb (port: uint16, value: uint8): void = "mac#outb"
fun outw (port: uint16, value: uint16): void = "mac#outb"
fun outl (port: uint16, value: uint32): void = "mac#outb"
