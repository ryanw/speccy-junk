include "map.asm"

clear_screen:

  ; Clear pixel memory
  ld hl, PIXELS_ADDR
  ld de, PIXELS_ADDR + 1
  ld bc, PIXELS_LEN
  ld (hl), $00
  ldir

  ; Clear colour attribs
  ld a, FG_PINK ^ BG_BLACK ^ BRIGHT
  ld bc, COLOURS_LEN
  ld (hl), a
  ldir

  ; Set border
  ld a, FG_BLACK
  call SET_BORDER

  ret


; FIXME Name this better
; bc: start of sprite
; sprite = { defb X, defb Y, defw (image) }
set_cell_address:
  ld hl, PIXELS_ADDR

  ; Load X position (first byte) of sprite object into 'a'
  ld a, (bc)
  ld d, 0x00
  ld e, a
  ; Increase X offset
  add hl, de

  ; Load Y position (second byte) of sprite object into 'a'
  inc bc
  ld a, (bc)
  ; Bits 4 and 5 give us the offset for the segment of the screen we want (0, 8 or 16)
  and %00011000
  ; Add the start location of screen pixels
  add SCREEN_TOP

  ; Set high byte to the start of the segment
  ld h, a

  ; Revert back to original Y coord value
  ld a, (bc)
  ; Bits 1, 2 ane 3 give us the offset inside the segment of the screen
  and %00000111
  ; Multiply by 32 (num of cells in a row)
  rrca
  rrca
  rrca
  ; Set low byte to the offset
  add l
  ld l, a

  ; Load address of source image into DE
  inc bc
  ld a, (bc)
  ld e, a
  inc bc
  ld a, (bc)
  ld d, a

  ret

draw_cell:
  push bc
  call set_cell_address
  ; 8 loops
  ld b, 8
  push hl
  push de
  call draw_cell_row
  pop de
  pop hl

  call draw_again
  call draw_again
  call draw_again
  call draw_again

  pop bc
  ret

draw_again:
  inc hl
  ld b, 8
  push hl
  push de
  call draw_cell_row
  pop de
  pop hl
  ret



; DE is pointing to first byte of the sprite's pixels
; HL is pointing to destination in framebuffer
draw_cell_row:
  ld a, (de)
  xor (hl)
  ;ld (hl), a
  ld (hl), a

  inc h
  inc de
  djnz draw_cell_row

  ret
