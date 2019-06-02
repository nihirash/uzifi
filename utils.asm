; Select memory bank 
; A - memory bank
setBank:
    push bc
    ld bc, #7ffd
    and 7
    or #60
    out (c), a
    pop bc
    ret

