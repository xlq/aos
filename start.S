.global _start

/* Stack used for boot code. */
STACK_SIZE = 4096 /* ought to be enough for anyone */
.global STACK_SIZE

.section multiboot, "a"

/* multiboot header
   http://www.gnu.org/software/grub/manual/multiboot/multiboot.html */
mb_header:
.int 0x1BADB002 /* magic */
.int 0x00000002 /* flags */
.int 0xE4524FFC /* checksum */

.section startup, "ax"

_start:
    cli
    cld
    movb $0x80,%al
    outb %al,$0x70  /* disable NMI */

    /* Set up initial stack. */
    movl $(stack + STACK_SIZE),%esp

    /* Clear flags. */
    pushl $0
    popf

    /* Push multiboot start-up parameters from bootloader. */
    pushl %eax /* magic */
    pushl %ebx /* mb_info */

    call _2boot_2edats__staload
    call _2boot_2edats__dynload
    call ats_entry_point

    /* fall through */
hang:
    cli
    hlt
    jmp hang

.global _2boot_2edats__dynload_flag
_2boot_2edats__dynload_flag:
    .int 0

.bss
stack:
.fill STACK_SIZE,1,0
stack_bottom:
.global stack_bottom
