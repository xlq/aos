stadef NUL = '\0'
sortdef cgz = {c: char | c <> NUL}
typedef c1har = [ch: cgz] char ch

fun idx_string_int
  {len: Nat} {i: Nat}
  (s: string len, i: int i): c1har
  = "mac#atspre_idx_char"
overload [] with idx_string_int
