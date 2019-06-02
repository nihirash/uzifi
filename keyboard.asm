LAST_K = 23560

; Returns in A key code or zero if key wans't pressed
inkey:
    ld hl, LAST_K
    ld a, (hl)
    ld (hl), 0
    ret