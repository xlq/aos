viewtypedef enablable (vt:viewt@ype) =
  [enabled: bool] @{ enabled = bool enabled, obj = opt (vt, enabled) }

fun {vt:viewt@ype} empty (): enablable vt
