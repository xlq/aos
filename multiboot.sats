staload "bitflags.sats"
staload "prelude/limits.sats"

#define MULTIBOOT_MBH_MAGIC 0x1BADB002  // magic number in multiboot header
#define MULTIBOOT_BOOT_MAGIC 0x2BADB002 // magic number in eax at start-up

#define MBI_MEM_XXX           0
#define MBI_BOOT_DEVICE       1
#define MBI_CMDLINE           2
#define MBI_MODS_XXX          3
#define MBI_AOUT_SYMS         4
#define MBI_ELF_SYMS          5
#define MBI_MMAP_XXX          6
#define MBI_DRIVES_XXX        8
#define MBI_BOOT_LOADER_NAME  9
#define MBI_APM_TABLE         10
#define MBI_VBE_XXX           11

viewtypedef mb_info = [flags: Uint32] @{
  flags       = uint32 flags,
  mem_lower   = uint32,
  mem_upper   = uint32,
  boot_device = uint32,
  cmd_line    = uint32,
  mods_count  = uint32,
  mods_addr   = uint32,
  (* Only valid for ELF - aout kludge
     uses different fields here. *)
  e_shnum     = uint32,
  e_shentsize = uint32,
  e_shaddr    = uint32,
  e_shstrndx  = uint32,
  mmap_length = uint32,
  mmap_addr   = uint32,
  drives_length     = uint32,
  drives_addr       = uint32,
  config_table      = uint32,
  boot_loader_name  = opt (string, bit_is_set (flags, MBI_BOOT_LOADER_NAME)),
  apm_table         = uint32,
  vbe_control_info  = uint32,
  vbe_mode_info     = uint32,
  vbe_mode          = uint16,
  vbe_interface_seg = uint16,
  vbe_interface_off = uint16,
  vbe_interface_len = uint16
}

typedef mb_module = @{
  mod_start   = uint32,
  mod_end     = uint32,
  string      = uint32,
  reserved    = uint32
}

typedef mb_mmap = @{
  size = uint32,
  base_addr = uint64,
  length = uint64,
  type = uint32
}

typedef mb_drive = @{
  size            = uint32,
  drive_number    = uint8,
  drive_mode      = uint8,
  drive_cylinders = uint16,
  drive_heads     = uint8,
  drive_sectors   = uint8,
  drive_ports     = uint16 // array
}
