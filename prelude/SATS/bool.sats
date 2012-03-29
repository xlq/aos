fun add_bool_bool (a: bool, b: bool):<> bool = "mac#atspre_oror"
fun mul_bool_bool (a: bool, b: bool):<> bool = "mac#atspre_andand"
overload || with add_bool_bool
overload && with mul_bool_bool

fun add_bool1_bool1
  {a, b: bool} (a: bool a, b: bool b):<> bool (a || b)
  = "mac#atspre_oror"

fun mul_bool1_bool1
  {a, b: bool} (a: bool a, b: bool b):<> bool (a && b)
  = "mac#atspre_andand"
overload || with add_bool1_bool1
overload && with mul_bool1_bool1
