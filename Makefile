ATSHOME ?= $(PWD)
ATSHOMERELOC ?= 
ATSOPT ?= ATSHOME=$(ATSHOME) ATSHOMERELOC=$(ATSHOMERELOC) $(ATSHOME)/bin/atsopt
CC ?= gcc
CFLAGS ?= -std=c99 -Wall -Wextra -Wno-unused -pedantic -Os -m32 -nostdlib -fno-stack-protector -ffunction-sections -fdata-sections -fomit-frame-pointer -g
LDFLAGS ?= -m32 -nostdlib -Wl,--build-id=none
V ?= 0 # Verbosity

SOURCES = prelude/limits.sats portio.sats \
          boot.dats vga-text.sats vga-text.dats \
          enablable.sats enablable.dats \
          serial.sats serial.dats trace.sats trace.dats \
          gdt.sats gdt.dats

ifeq ($(strip $(V)),0)
.SILENT:

ECHO = echo
ATSSTR = "    ATS   $<"
CCSTR  = "    CC    $<"
LDSTR  = "    LD    $@"
NMSTR  = "    NM    $<"
else
ECHO = @\#
endif

as_sources := start.S
sats_sources := $(filter %.sats,$(SOURCES))
dats_sources := $(filter %.dats,$(SOURCES))
sats_objects := $(patsubst %.sats,%_sats.o,$(sats_sources))
dats_objects := $(patsubst %.dats,%_dats.o,$(dats_sources))
objects := $(sats_objects) $(dats_objects)

clean_files := test $(objects) $(objects:.o=.c)

.PHONY: all always

all: kernel syms

# Link twice: once without --gc-sections to check elaborations
# then with --gc-sections to remove unused sections.
kernel: $(objects) $(as_sources) kernel.ld
	$(ECHO) $(LDSTR)
	$(CC) $(LDFLAGS) -Wl,-T,kernel.ld -o $@ $(as_sources) $(objects)
	$(CC) $(LDFLAGS) -Wl,--gc-sections,-T,kernel.ld -o $@ $(as_sources) $(objects)

syms: kernel
	$(ECHO) $(NMSTR)
	nm kernel > syms

# Do all ATS compiling before C compiling. It looks nicer! :-D
$(sats_objects) $(dats_objects): %.o: %.c | $(sats_objects:.o=.c) $(dats_objects:.o=.c)
	$(ECHO) $(CCSTR)
	$(CC) $(CFLAGS) -I. -c -o $@ $<

$(dats_objects:.o=.c): %_dats.c: %.dats
	$(ECHO) $(ATSSTR)
	$(ATSOPT) --gline --output $@ --dynamic $< || { $(RM) $@ ; false ; }

$(sats_objects:.o=.c): %_sats.c: %.sats
	$(ECHO) $(ATSSTR)
	$(ATSOPT) --gline --output $@ --static $< || { $(RM) $@ ; false ; }

.PHONY: depend

depend:
	$(ECHO) "    Analysing dependencies..."
	$(ATSOPT) -dep1 -s $(sats_sources) -d $(dats_sources) \
		| sed -r 's/^ *([^:]*)\.o *:/\1.c :/' > .depends.mak

.PHONY: clean

clean:
	$(ECHO) "    Cleaning..."
	$(ECHO) "    "$(clean_files)
	$(RM) $(clean_files)

-include .depends.mak
