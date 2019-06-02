    DEVICE ZXSPECTRUM128
    org 32768
Start:
        ei
        call clearScreen
        call uartBegin
        ld b, 1
        ld c, 0
        call gotoXY
        call initWifi
		
        jr $

stringE: defb 'UZiFi by Nihirash (c) 2019', 0
ssid    defb 'PinnCom', 0
pass    defb 'Lobotomy', 0

    include "utils.asm"
    include "uart.asm"
    include "screen64.asm"
    include "keyboard.asm"
    include "wifi.asm"
    include "ring.asm"
    SAVESNA "test.sna", Start

