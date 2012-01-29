staload "vga-text.sats"
staload "portio.sats"

assume colour = [x:nat | x < 16] int x
implement black            = 0
implement blue             = 1
implement green            = 2
implement cyan             = 3
implement red              = 4
implement magenta          = 5
implement brown            = 6
implement white            = 7
implement grey             = 8
implement bright_blue      = 9
implement bright_green     = 10
implement bright_cyan      = 11
implement bright_red       = 12
implement bright_magenta   = 13
implement bright_yellow    = 14
implement bright_white     = 15

prval pf_exp_2_4: EXP2(4,0x10) =
  EXP2ind(EXP2ind(EXP2ind(EXP2ind(EXP2bas()))))

prval pf_exp_2_8: EXP2(8,0x100) =
  EXP2ind(EXP2ind(EXP2ind(EXP2ind(pf_exp_2_4))))

prval pf_exp_2_16: EXP2(16,0x10000) =
  EXP2ind(EXP2ind(EXP2ind(EXP2ind(
  EXP2ind(EXP2ind(EXP2ind(EXP2ind(pf_exp_2_8))))))))

typedef cell = @{ ch = char, attrib = uint8 }

absview vram (l: addr)

viewtypedef tmat2 (width: int, height: int, x: int, y: int) =
  [l: agz] [width * height >= 1 && width * height <= INT_MAX]
  [x < width] [y < height]
  @{
    width = int width,
    height = int height,
    x = int x,
    y = int y,
    attrib = uint8, // current colours
    fr_vram = vram l,
    pf_vram = @[cell][width*height] @ l,
    vram = ptr l
  }

viewtypedef tmat1 (width: int, height: int) =
  [x: nat | x < width] [y: nat | y < height]
  tmat2 (width, height, x, y)

viewtypedef tmat = [width, height: Pos] tmat1 (width, height)

assume console = tmat

extern fun get_vram ():
  [l: agz] (vram l, @[cell][80*25] @ l | ptr l)
  = "mac#get_vram"

extern prfun eat_vram {l: agz} {n: int}
  (fr: vram l, pf: @[cell][n] @ l): void

%{^
  #define get_vram() ((void *) 0xB8000)
%}

prfn mul_lt {w,h,x,y:nat | x < w && y < h}
  (): [y*w+x < w*h && y*w >= 0] void =
let
  prval pf_yw = mul_istot {y, w} ()
  prval pf_wh = mul_istot {w, h} ()
  prval pf_y1w = mul_istot {y+1, w} ()
  prval () = mul_nat_nat_nat pf_yw
  prval () = mul_nat_nat_nat pf_wh
  prval () = mul_nat_nat_nat (mul_distribute2 (mul_negate pf_y1w, mul_commute pf_wh))
  prval () = mul_isfun (pf_y1w, mul_add_const {1} (pf_yw))
  prval () = mul_elim pf_wh
  prval () = mul_elim pf_yw
in
  ()
end

implement default_colours (con) = con.attrib := uint8_of 7u

implement set_colour (con, fg) =
  con.attrib := uint8_of (
    (uint_of con.attrib land 0xF0u)
    lor uint1_of fg)

implement set_background (con, bg) =
let
  val (pfbg' | bg') = ushl2 (pf_exp_2_4 | uint1_of bg, 4)
  prval () = EXP2_isfun (pfbg', pf_exp_2_8)
  val bg' = uint8_of bg'
in
  con.attrib := ((con.attrib land uint8_of 0x0Fu) lor bg')
end

(* Get position of the hardware cursor. *)
fn get_hw_cursor {w,h:Pos}
  (self: &tmat1(w,h)): void =
let
  val () = outb (uint16_of 0x3D4u, uint8_of 14u)
  val pos_hi = inb (uint16_of 0x3D5u)
  val () = outb (uint16_of 0x3D4u, uint8_of 15u)
  val pos_lo = inb (uint16_of 0x3D5u)
  val pos = ushl (pf_exp_2_8 |
      uint_of pos_hi, 8)
    lor uint_of pos_lo
  val pos_y = pos / uint1_of self.width
in
  if pos_y < uint1_of self.height then
    self.y := int1_of pos_y
  else
    self.y := self.height - 1; // out of range!
  self.x := int1_of (pos mod uint1_of self.width)
end

(* Set position of the hardware cursor. *)
fn set_hw_cursor {w,h:Pos} {x,y:Nat | x < w && y < h}
  (self: &tmat2(w,h,x,y)): void =
let
  prval () = mul_lt {w,h,x,y} ()
  val tmp = uint1_of (self.y * self.width + self.x)
in
  if tmp <= uint1_of UINT16_MAX then
    let
      val (pftmphi | tmp_hi) = ushr2 (pf_exp_2_16 | tmp, 8)
      prval () = EXP2_isfun (pftmphi, pf_exp_2_8)
      val () = outb (uint16_of 0x3D4u, uint8_of 14u)
      val () = outb (uint16_of 0x3D5u, uint8_of tmp_hi)
      val () = outb (uint16_of 0x3D4u, uint8_of 15u)
      val () = outb (uint16_of 0x3D5u, uint8_of (tmp land 0xFFu))
    in
      ()
    end
end

(* move_elements (arr, from, to, count)
   Move count elements from "from" to "to". *)
fn {t: t@ype} move_elements
  {len: Nat} {from, to, count: nat | from + count <= len && to + count <= len && to <= from}
  (arr: &(@[t][len]), from: int from, to: int to, count: int count): void
= loop (arr, from, to, count, 0) where {
  fun loop {i: nat | i <= count} .<count-i>.
    (arr: &(@[t][len]),
     from: int from,
     to: int to,
     count: int count,
     i: int i): void
  =
    if i < count then begin
      arr.[to+i] := arr.[from+i];
      loop (arr, from, to, count, i+1)
    end
}

fun {t: t@ype} set_elements
  {len: Nat} {start, count: nat | start + count <= len} .<count>.
  (arr: &(@[t][len]), start: int start, count: int count, elem: t): void
=
  if count > 0 then begin
    arr.[start] := elem;
    set_elements (arr, start+1, count-1, elem)
  end

fn put_char_at
  {width, height, x0, y0: Nat | x0 < width && y0 < height}
  {x, y: Nat | x < width && y < height}
  (mat: &tmat2(width, height, x0, y0), x: int x, y: int y, ch: char): void
=
  let
    prval () = mul_lt {width, height, x, y} ()
    prval pf_vram = mat.pf_vram
  in
    mat.vram->[y * mat.width + x] := @{ ch = ch, attrib = mat.attrib };
    mat.pf_vram := pf_vram
  end

fn scroll {w,h: Pos} {x,y: Nat}
  (self: &tmat2(w,h,x,y)): void =
let
  prval () = mul_pos_pos_pos (mul_make {h,w} ())
  prval () = mul_isfun (mul_add_const {~1} (mul_make {h,w} ()),
                        mul_make {h-1,w} ())
  prval () = mul_elim (mul_commute (mul_make {h,w} ()))
  prval pf_vram = self.pf_vram
in
  move_elements (!(self.vram), self.width, 0,
    (self.height - 1) * self.width);
  set_elements (!(self.vram), (self.height - 1) * self.width,
    self.width, @{ ch = ' ', attrib = uint8_of 7u });
  self.pf_vram := pf_vram
end

fn newline (self: &console): void =
begin
  self.x := 0;
  if self.y < self.height - 1 then
    self.y := self.y + 1
  else
    scroll self
end

fn put_char_inner (self: &console, ch: c1har): void =
begin
  if ch = '\n' then newline self
  else begin
    put_char_at (self, self.x, self.y, ch);
    if self.x < self.width - 1 then begin
      self.x := self.x + 1
    end else newline self
  end
end

implement put_char (con, ch) =
begin
  put_char_inner (con, ch);
  set_hw_cursor con
end

implement put_string {len} (con, len, str)
= loop (con, len, str, 0) where {
  fun loop {i: Nat | i <= len} .<len-i>.
    (self: &console, len: int len,
     str: string len, i: int i): void
  =
    if i < len then begin
      put_char_inner (self, str[i]);
      loop (self, len, str, i+1)
    end else begin
      set_hw_cursor self
    end
}

implement init_B8000 (pf_con | con) =
let
  val (fr_vram, pf_vram | vram) = get_vram ()
in
  !con := @{
    width = 80, height = 25,
    x = 0, y = 0,
    attrib = uint8_of 7u,
    fr_vram = fr_vram, pf_vram = pf_vram,
    vram = vram
  };
  get_hw_cursor !con;
  (True_v pf_con | true)
end

implement finit (con) =
let prval () = eat_vram (con.fr_vram, con.pf_vram) in () end
