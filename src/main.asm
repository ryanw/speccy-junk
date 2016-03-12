include "constants.asm"

org CODE_START_ADDR

main:
  call init_screen

  ld hl, test_map
  call draw_map

  ld bc, sprite1
  call draw_cell

  ld bc, sprite2
  call draw_cell

  ld bc, sprite3
  call draw_cell

loop:
  ld bc, sprite1
  call draw_cell  ; Clear the old sprite
  ld bc, sprite2
  call draw_cell  ; Clear the old sprite
  ld bc, sprite3
  call draw_cell  ; Clear the old sprite

  call check_keys

  ld bc, sprite1
  call draw_cell ; Draw at new position
  ld bc, sprite2
  call draw_cell ; Draw at new position
  ld bc, sprite3
  call draw_cell ; Draw at new position


  halt ; V Sync

  jr loop
  ret

; Adjust sprite's position by DE
; BC = Sprite address
; D = X amount
; E = Y amount
move_sprite:
  push af
  push bc

  ; X
  ld a, (bc)
  add a, d
  ld (bc), a

  ; Y
  inc bc
  ld a, (bc)
  add a, e
  ld (bc), a

  pop bc
  pop af
  ret

init_screen:
  ld a, UPPER_SCREEN
  call OPEN_CHANNEL
  call clear_screen
  ret

print_message:
  ; Load char into A
  ld a, (bc)

  ; if value in A (char) is 0 then exit
  cp 0
  jr z, print_message_exit

  ; Print A
  rst $10

  ; Move to next char
  inc bc

  ; Loop
  jr print_message

print_message_exit:
  ret

wait:
  nop
  jp wait
  ret

banner1:
  defb "Ryan is cooler than you", 13, 0

banner2:
  defb "Purple monkey dishwasher", 13, 0

sprite1:
  defb 0x01
  defb 0x03
  defw face

sprite2:
  defb 0x01
  defb 0x04
  defw ball

sprite3:
  defb 0x01
  defb 0x05
  defw face

include "graphics.asm"
include "keyboard.asm"
include "images.asm"


