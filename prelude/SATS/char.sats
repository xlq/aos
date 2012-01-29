fun eq_char1_char1 {a, b: char}
  (a: char a, b: char b):<> bool (a == b)
  = "mac#atspre_eq"
overload = with eq_char1_char1

castfn uint8_of_char (a: char):<> uint8
overload uint8_of with uint8_of_char
