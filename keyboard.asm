LAST_K = 23560

inkey:
    ld hl, LAST_K
    ld a, (hl)
    ld (hl), 0
    ret