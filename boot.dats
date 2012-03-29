staload "prelude/limits.sats"

typedef cell = @{ ch = char, attr = uint8 }

absview vram (l: addr)

viewtypedef tmat2 (width: int, height: int, x: int, y: int) =
  [l: agz] [width * height >= 1 && width * height <= INT_MAX]
  [x < width] [y <= height]
  @{
    width = int width,
    height = int height,
    x = int x,
    y = int y,
    fr_vram = vram l,
    pf_vram = @[cell][width*height] @ l,
    vram = ptr l
  }

viewtypedef tmat1 (width: int, height: int) =
  [x: nat | x < width] [y: nat | y <= height]
  tmat2 (width, height, x, y)

viewtypedef tmat = [width, height: Pos] tmat1 (width, height)

extern fun get_vram ():
  [l: agz] (vram l, @[cell][80*25] @ l | ptr l)
  = "mac#get_vram"

extern prfun eat_vram {l: agz}
  (fr: vram l, pf: @[cell][80*25] @ l): void

%{^
  #define get_vram() ((void *) 0xB8000)
%}

// x<w & y<h --> yw+x < wh
prfn mul_lt
  {w, h: nat}
  {x: nat | x < w} {y: nat | y < h}
  {wh: nat} {yw: nat}
  (pf_wh: MUL(w,h,wh),
   pf_yw: MUL(y,w,yw)):
  [yw+x < wh] void
=
  let
    prval pf_y1w = mul_istot {y+1,w} ()
    prval () = mul_nat_nat_nat (mul_distribute2 (mul_negate pf_y1w, mul_commute pf_wh))
    prval () = mul_isfun (pf_y1w, mul_add_const {1} (pf_yw))
  in () end

prfn check {b: bool | b == true} (): void = ()

fn {t: t@ype} move_elements
  {len: Nat} {from, to, count: nat | from + count <= len && to + count <= len}
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

fn put_char_at
  {width, height, x0, y0: Nat}
  {x, y: Nat | x < width && y < height}
  (mat: &tmat2(width, height, x0, y0), x: int x, y: int y, ch: char): void
=
  let
    prval pf_yw = mul_istot {y, width} ()
    prval pf_wh = mul_istot {width, height} ()
    prval () = mul_nat_nat_nat pf_yw
    prval () = mul_nat_nat_nat pf_wh
    prval () = mul_lt {width, height} {x} {y} (pf_wh, pf_yw)
    prval () = mul_elim pf_wh
    prval () = mul_elim pf_yw
    val (pf_yw' | yw) = y imul2 mat.width
    prval () = mul_isfun (pf_yw, pf_yw')
    prval pf_vram = mat.pf_vram
  in
    mat.vram->[yw + x] := @{ ch = ch, attr = uint8_of_uint 7u };
    mat.pf_vram := pf_vram
  end

fn scroll {w,h: Pos} {x,y: Nat}
  (self: &tmat2(w,h,x,y)): void =
let
  // wh > w
  prval () = mul_pos_pos_pos (mul_make {h,w} ())
  // wh > wh-w
  prval () = check {h*w > h*w-w} ()
  // wh-w = w(h-1)
  prval pfhw1: MUL(h-1, w, h*w-w) =
    mul_add_const {~1} (mul_make {h,w} ())
  prval () = mul_isfun (pfhw1, mul_make {h-1,w} ())
  // wh > w(h-1)
  prval () = check {h*w > (h-1)*w} ()

  prval () = mul_elim (mul_commute (mul_make {h,w} ()))
  prval pf_vram = self.pf_vram
in
  move_elements (!(self.vram), self.width, 0,
    (self.height - 1) * self.width);
  self.pf_vram := pf_vram
end

fn put_char {width, height: Pos}
  (self: &tmat1(width, height), ch: c1har): void =
begin
  (* Ensure cursor is on the screen. *)
  if self.y = self.height then begin
    scroll self;
    self.y := self.y - 1;
    scrolled (self, ch)
  end else begin
    scrolled (self, ch)
  end
end where {
  fn scrolled {x,y: Nat | y < height}
    (self: &tmat2(width, height, x, y) >> tmat1(width, height), ch: c1har): void =
  begin
    if ch = '\n' then begin
      (* New line. *)
      self.x := 0;
      self.y := self.y + 1
    end else begin
      put_char_at (self, self.x, self.y, ch);
      if self.x < self.width - 1 then begin
        self.x := self.x + 1
      end else begin
        self.x := 0;
        self.y := self.y + 1
      end
    end
  end
}

fn put_string {w,h: Pos} {len: Nat}
  (self: &tmat1(w,h), len: int len, str: string len): void
= loop (self, len, str, 0) where {
  fun loop {i: Nat | i <= len} .<len-i>.
    (self: &tmat1(w,h), len: int len,
     str: string len, i: int i): void
  =
    if i < len then begin
      put_char (self, str[i]);
      loop (self, len, str, i+1)
    end
}

extern fun ats_entry_point (): void = "ats_entry_point"
implement ats_entry_point () =
let
  val (fr_vram, pf_vram | vram) = get_vram ()
  var tty1: tmat = @{
    width = 80, height = 25,
    x = 0, y = 0,
    fr_vram = fr_vram, pf_vram = pf_vram,
    vram = vram
  }
in
  loop (tty1, 1000) where {
    fun loop {w,h: Pos} {i: Nat} .<i>.
      (tty: &tmat1(w,h), i: int i): void =
    begin
      put_string (tty, 14, "Hello, world!\n");
      put_string (tty, 14, "AOentaohetnh!\n");
      put_string (tty, 14, "tnehaonethnh!\n");
      put_string (tty, 14, "Cbaogeohetnh!\n");
      put_string (tty, 14, "CGdc.gdeounh!\n");
      put_string (tty, 14, "Bmbwboetbunh!\n");
      put_string (tty, 14, ">PRgc,.bbeuh!\n");
      put_string (tty, 14, "EGOBJ ohetnh!\n");
      put_string (tty, 14, "!!!!!!!hetnh!\n");
      put_string (tty, 14, "???????hetnh!\n");
      if i > 0 then loop (tty, i-1)
    end
  };
  let prval () = eat_vram (tty1.fr_vram, tty1.pf_vram) in () end
end
