initWifi:
    ld hl, cmd_at
    call okErrCmd
    ret

; HL - Cmd
okErrCmd: 
    call uartWriteStringZ
    ret

waitSec: ld b, #ff
wLop:    halt
         djnz wLop
         ret 

cmd_at  defb 'ATE0', 13, 10, 0
cmd_gmr defb 'AT+GMR', 13, 10, 0
output_buffer dup 256
              defb 0
              edup 