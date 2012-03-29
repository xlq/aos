staload "integers.sats"
staload Serial = "serial.sats"

extern fun ats_entry_point (): void = "ats_entry_point"

implement ats_entry_point () =
  let
    var ttyS1 = $Serial.new
  in
    if $Serial.init (ttyS1, 1, 115200) then begin
      $Serial.send_char (ttyS1, 'H');
      $Serial.send_char (ttyS1, 'e');
      $Serial.send_char (ttyS1, 'l');
      $Serial.send_char (ttyS1, 'l');
      $Serial.send_char (ttyS1, 'o');
      $Serial.send_char (ttyS1, '\n')
    end
  end
