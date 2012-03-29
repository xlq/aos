ENTRY (_start)
OUTPUT_FORMAT(elf32-i386)

_phys_base = 0x00100000 ; /* physical base address of kernel (where GRUB will load it) */

PHDRS {
    physical PT_LOAD FLAGS(7) ;
}

SECTIONS {
    /* put the multiboot header at the very start of the image,
       then the start-up code. Link at physical addresses. */

    .start _phys_base : AT(_phys_base) {
        _text_start = . ;
        KEEP(*(multiboot))
        *(startup)
        . = ALIGN(32) ;
    } :physical

    .text . : AT( _phys_base + SIZEOF(.start) ) {
        *(.text .text.*)
        . = ALIGN(32) ;
    } :physical

    .rodata : {
        *(.rodata .rodata.*)
        . = ALIGN(32) ;
    } :physical

    .data : {
        *(.data .data.*)
        . = ALIGN(32) ;
    } :physical

    .bss : {
        *(.bss .bss.*)
        *(COMMON)
    } :physical

    _edata = ADDR(.bss) ;
    _end = _edata + SIZEOF(.bss) ;

    /DISCARD/ : {
        *(.note .note*)
        *(.comment)
        *(.eh_frame) /* eh_frame is not used */
    }
}
