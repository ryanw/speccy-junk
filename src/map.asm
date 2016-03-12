; HL: Map to draw
draw_map:

  ; BC: address for tileset
  ld c, (hl)
  inc hl
  ld b, (hl)

; BC: start of tileset
; HL: start of map tiles
draw_map_tile:
; DE: destination for data
  ld de, PIXELS_ADDR

next_tile:
  inc hl

  ; Load tile number into A
  ld a, (hl)

  ; if tile is 0xFF then we're done
  cp 0xff
  jp z, draw_map_done

  ; Save HL, BC for next loop
  push hl
  push bc

  ; if tile is 0 skip to next
  cp 0
  jp z, next_tile_done


  ; Remove 1 from the tile numer to allow for 0x00
  dec a

  ; Move BC into HL
  push bc
  pop hl
  ; Add A*8(char width) to HL
  add a
  add a
  add a
  add l
  ld l, a

  call draw_map_tile_char
next_tile_done:
  inc de

  ; Restore HL, BC
  pop bc
  pop hl
  jp next_tile



; HL: Address of tile we need to draw
; DE: Address of destination
draw_map_tile_char:
  push hl
  push de
  ; Copy HL into DE 8 times for 1 char
  ld b, 8
draw_map_tile_char_loop:
  ld a, (hl)
  ld (de), a
  inc d
  inc hl
  djnz draw_map_tile_char_loop

  pop de
  pop hl


draw_map_done:
  ret
