ENTRY (_start)
OUTPUT_FORMAT(elf32-i386)

/* Physical base address of kernel.
   Boot loader loads the kernel image here. */
_phys_base = 0x00100000 ;

/* Virtual base address of kernel.
   This is the address the kernel will run at,
   after paging is enabled in start.S. */
_virt_base = 0x00100000 ;

PHDRS {
    physical PT_LOAD FLAGS(7) ;
    virtual PT_LOAD FLAGS(7) ;
}

SECTIONS {
    .start _phys_base : AT(_phys_base) {
        _text_start = . ;
        /* The multiboot header must be near the start of the image.
           It is not referenced by any code, hence "KEEP" to avoid
           it being discarded. */
        KEEP(*(multiboot))
        /* The start-up code that runs before paging is enabled.
           This must be linked at physical addresses. */
        *(startup)
        . = ALIGN(32) ;
    } :physical

    /* Kernel code starts at virtual addresses. */
    .text . - _phys_base + _virt_base : AT( _phys_base + SIZEOF(.start) ) {
        *(.text .text.*)
        . = ALIGN(32) ;
    } :virtual

    .rodata : {
        *(.rodata .rodata.*)
        . = ALIGN(32) ;
    }

    .data : {
        *(.data .data.*)
        . = ALIGN(32) ;
    }

    .bss : {
        _bss_start = . - _virt_base + _phys_base ;
        *(.bss .bss.*)
        *(COMMON)

        /* Allocate aligned memory for initial page tables. */
        . = ALIGN(4096) ;
        boot_page_directory = . - _virt_base + _phys_base ;
        . = . + 1 ;
        . = ALIGN(4096) ;
        boot_page_table = . - _virt_base + _phys_base ;
        . = . + 1 ;
        . = ALIGN(4096) ;
        _bss_end = . - _virt_base + _phys_base ;
    }

    _kernel_size = . - _virt_base ;

    /DISCARD/ : {
        *(.note .note*)
        *(.comment)
        *(.eh_frame) /* eh_frame is not used. */
    }
}
