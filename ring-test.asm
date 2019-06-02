    DEVICE ZXSPECTRUM48
    org 32768
Start:
    di
    ld a, 'O'
    call pushRing
    ld a, 'K'
    call pushRing
    ld a, 13
    call pushRing
    ld a, 10
    call pushRing
    ld hl, testString
    call searchRing
    jr $

testString
    defb 'OK', 13, 10, 0
    include "ring.asm"
    savesna "ring-test.sna", Start