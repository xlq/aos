ATSHOME ?= $(PWD)
ATSHOMERELOC ?= ATS-0.2.6
ATSCC ?= ATSHOME=$(ATSHOME) ATSHOMERELOC=$(ATSHOMERELOC) $(ATSHOME)/bin/atscc
ATSOPT ?= atsopt
CC ?= gcc
ATSFLAGS ?= -Os -m32 -nostdlib -fno-stack-protector -ffunction-sections -fdata-sections -fomit-frame-pointer -g
LDFLAGS ?= -m32 -nostdlib -Wl,--gc-sections,--build-id=none

SOURCES = boot.dats

as_sources := start.S
sats_sources := $(filter %.sats,$(SOURCES))
dats_sources := $(filter %.dats,$(SOURCES))
sats_objects := $(patsubst %.sats,%_sats.o,$(sats_sources))
dats_objects := $(patsubst %.dats,%_dats.o,$(dats_sources))
objects := $(sats_objects) $(dats_objects)

clean_files := test $(objects) $(objects:.o=.c)

.PHONY: all always

all: kernel syms

kernel: $(objects) $(as_sources) kernel.ld
	$(CC) $(LDFLAGS) -Wl,-T,kernel.ld -o $@ $(as_sources) $(objects)

syms: kernel
	nm kernel > syms

$(dats_objects): %_dats.o: %.dats
	$(ATSCC) $(ATSFLAGS) -c $<

$(sats_objects): %_sats.o: %.sats
	$(ATSCC) $(ATSFLAGS) -c $<

.PHONY: depend

depend:
	$(ATSOPT) -dep1 -d $(dats_sources) > .depends.mak
	$(ATSOPT) -dep1 -s $(sats_sources) >> .depends.mak

.PHONY: clean

clean:
	$(RM) $(clean_files)

-include .depends.mak
