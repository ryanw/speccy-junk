org 0x8000

MAIN:
    xor a
    ld hl, 0x4000
    add hl, (pos_x)
    ld (hl), %01010101


LOOP:
    jp LOOP

    ret


pos_x: defb 0
pos_y: defb 0
