AOS - Applied Operating System
==============================

Aims
----

To be written in ATS (http://www.ats-lang.org/), which is a programming
language that has a very flexible type system, supporting dependent and
linear types. The language compiles straightforwardly to C, with no
garbage collection (by default), making it very useful for low-level
programming. ATS's type system can be used to prove at compile-time, among many
other properties, the absence of memory leaks, double frees, dangling
pointers, uninitialised value or pointer use and integer overflow.

Compiling
---------

AOS defines operators on integers such that they cannot be called if the
operation would overflow. This requires ATS's constraint solver to
handle large integers. The current release of ATS, "Anairiats", is
unable to handle such large numbers in the constraint solver
(ironically, integers in the constraint solver overflow), so included with AOS
is a patch to use bignums in the constraint solver.

The ATS compiler is written in ATS, but because it translates to C, the
compiler can be boot-strapped by compiling intermediate C sources.
AOS's makefile contains a rule to check out (from subversion) and build a copy
of the ATS compiler automatically. Run:
    
    make compiler

in the AOS directory. Then you can compile AOS with:

    make depend
    make

Use `make V=1` to echo commands.

Features
--------

* 486SX-compatible. There's no reason it shouldn't run on i386 too, but it's
  not tested.
* It prints greetings to the serial port!

Booting
-------

AOS compiles to a
[multiboot] (http://www.gnu.org/software/grub/manual/multiboot/multiboot.html)
ELF file called, believe it or not, `kernel`, linked at `0x00100000`. A small
amount of code in `start.S` identity-maps the first four megabytes of physical
memory, turns on paging and jumps to ATS code, which can be linked at virtual
addresses different to the physical addresses (but isn't now).

Use a multiboot-compliant boot-loader such as
[GNU GRUB] (http://www.gnu.org/software/grub/) to boot AOS, or run it in QEMU with

    qemu -kernel kernel
