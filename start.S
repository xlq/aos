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
    /* Entry point from boot loader.
       eax contains magic number 0x2BADB002.
       ebx contains a pointer to mb_info. */
    movl %eax,%edx /* magic */

    /* Disable interrupts. */
    cli
    cld

    /* Disable NMI. */
    movb $0x80,%al
    outb %al,$0x70

    /* Zero out bss section, in case boot loader didn't.
       (ebx, edx are still live here) */
    movl $_bss_start,%edi
    movl $_bss_end,%ecx
    subl %edi,%ecx
    xorl %eax,%eax
    rep stosb

    /* Set up initial stack.
       The "stack" symbol points to a virtual address.
       Convert this to a physical address. */
    movl $stack_bottom,%esp
    subl $_virt_base,%esp
    addl $_phys_base,%esp

    /* Clear flags. */
    pushl $0
    popf

    /* Push multiboot start-up parameters from bootloader. */
    pushl %ebx /* mb_info */
    pushl %edx /* magic */

    /* Create initial page tables.
       0x00000000 .. 0x003FFFFF is mapped to 0x00000000 */
    movl $boot_page_table,%edi
    movl $0x00000003,%eax
    movl $1024,%ecx
1:  stosl
    addl $0x00001000,%eax
    decl %ecx
    jnz 1b

    /* Set page directory entries. */
    movl $boot_page_table,%eax
    orl $0x00000003,%eax
    movl %eax,(boot_page_directory + 0x000)

    /* Load page directory. */
    movl $boot_page_directory,%eax
    movl %eax,%cr3

    /* Enable paging. */
    movl %cr0,%eax
    bts $31,%eax
    movl %eax,%cr0

    /* Move stack pointer to virtual address. */
    subl $_phys_base,%esp
    addl $_virt_base,%esp

    /* Call dynamic elaboration code. */
    call ATS_2d0_2e2_2e9_2boot_2edats__staload
    call ATS_2d0_2e2_2e9_2boot_2edats__dynload

    /* Call entry point in boot.dats. */
    pushl $hang
    jmp ats_entry_point

.text
hang:
    cli
    hlt
    jmp hang

.data
.global ATS_2d0_2e2_2e9_2boot_2edats__dynload_flag
ATS_2d0_2e2_2e9_2boot_2edats__dynload_flag:
    .int 0

.bss
stack:
.fill STACK_SIZE,1,0
stack_bottom:
.global stack_bottom
