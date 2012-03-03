fun eq_char1_char1 {a, b: char}
  (a: char a, b: char b):<> bool (a == b)
  = "mac#atspre_eq"
overload = with eq_char1_char1

castfn ubyte_of_char (a: char):<> ubyte
overload ubyte_of with ubyte_of_char
