include "constants.asm"

org CODE_START_ADDR

jp main
ret

thing: defb 0x00

; Keys currently being pressed
keys: defb 0x00

; Possible key values
left:  equ %00000001
right: equ %00000010
up:    equ %00000100
down:  equ %00001000
fire:  equ %00010000

main:
  call init_screen

  ld bc, sprite1
  call draw_cell

  ld bc, sprite2
  call draw_cell

  ld bc, sprite3
  call draw_cell

loop:

  ld bc, sprite1
  call draw_cell  ; Clear the old sprite

  call check_keys

  call draw_cell ; Draw at new position

  halt ; V Sync
  halt ; V Sync
  halt ; V Sync

  jr loop
  ret

check_keys:
  push bc

  ; Load pressed key flags into a
  ld bc, KEYS_POIUY
  in a, (c)

  ; RIGHT P
  rra ; Pop off the end bit in the C flag
  call nc, handle_press_right

  ; LEFT O
  rra ; Pop off the next bit
  call nc, handle_press_left

  ;; Load other keys in
  ld bc, KEYS_QWERT
  in a, (c)

  ; UP Q
  rra
  call nc, handle_press_up

  ld bc, KEYS_ASDFG
  in a, (c)

  ; DOWN A
  rra
  call nc, handle_press_down

  pop bc
  ret


handle_press_left:
  ld bc, sprite1
  ld d, -0x01
  ld e, 0x00
  call move_sprite
  ret

handle_press_right:
  ld bc, sprite1
  ld d, 0x01
  ld e, 0x00
  call move_sprite
  ret

handle_press_up:
  ld bc, sprite1
  ld d, 0x00
  ld e, -0x01
  call move_sprite
  ret

handle_press_down:
  ld bc, sprite1
  ld d, 0x00
  ld e, 0x01
  call move_sprite
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
  defb 0x03
  defb 0x04
  defw ball

sprite3:
  defb 0x10
  defb 0x10
  defw face

face:
  defb %01010100
  defb %11111110
  defb %11010110
  defb %11111110
  defb %11101110
  defb %10111010
  defb %11000110
  defb %01111100

ball:
  defb %00000000
  defb %00111000
  defb %01010100
  defb %10101010
  defb %11010110
  defb %10101010
  defb %01010100
  defb %00111000

solid:
  defb %11111111
  defb %11111111
  defb %11111111
  defb %11111111
  defb %11111111
  defb %11111111
  defb %11111111
  defb %11111111


include "graphics.asm"
