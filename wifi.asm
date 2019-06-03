initWifi:
    ld hl, cmd_at
    call okErrCmd
    and 1
    jr z, errInit
    
    ld hl, cmd_cwqap
    call okErrCmd
    and 1
    jr z, errInit

    ld hl, cmd_cmux
    call okErrCmd
    and 1
    jr z, errInit

    ld hl, cmd_cwjap1
    call uartWriteStringZ
    ld hl, ssid
    call uartWriteStringZ
    ld hl, cmd_cwjap2
    call uartWriteStringZ
    ld hl, pass
    call uartWriteStringZ
    ld hl, cmd_cwjap3
    call okErrCmd

    and 1
    jr z, errInit
    
    ld hl, log_ok
    call printZ64 

    ret
errInit
    ld hl, log_err
    call printZ64
    jr $

; HL - Cmd
okErrCmd: 
    call uartWriteStringZ
okErrCmdLp:
    call uartReadBlocking
    call pushRing
    
    ld hl, response_ok
    call searchRing
    cp 1
    jr z, okErrOk
    
    ld hl, response_err
    call searchRing
    cp 1
    jr z, okErrErr

    ld hl, response_fail
    call searchRing
    cp 1
    jr z, okErrErr


    jp okErrCmdLp
okErrOk
    ld a, 1
    ret
okErrErr
    ld a, 0
    ret

waitSec: ld b, #ff
wLop:    halt
         djnz wLop
         ret 


cmd_at      defb "ATE0", 13, 10, 0
cmd_mode    defb "AT+CWMODE_DEF=1",13,10,0	
cmd_cmux    defb "AT+CIPMUX=0",13,10,0
cmd_cwqap   defb "AT+CWQAP",13,10,0		                    ; Disconnect from AP

cmd_cwjap1  defb  "AT+CWJAP_CUR=", #22,0        ;Connect to AP. Send this -> SSID
cmd_cwjap2  defb #22,',',#22,0                  ; -> This -> Password
cmd_cwjap3  defb #22, 13, 10, 0                 ; -> And this

response_ok     defb 13,10,'OK', 13, 10, 0
response_err    defb 13,10,'ERROR',13,10,0
response_fail   defb 13,10,'FAIL',13,10,0

log_err defb 'Failed talk to WiFi module!', 0
log_ok  defb 'WiFi connected!', 0
output_buffer dup 256
              defb 0
              edup 