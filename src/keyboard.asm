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
  ld d, -0x01
  ld e, 0x00
  ld bc, sprite1
  call move_sprite
  ld bc, sprite2
  call move_sprite
  ld bc, sprite3
  call move_sprite
  ret

handle_press_right:
  ld d, 0x01
  ld e, 0x00
  ld bc, sprite1
  call move_sprite
  ld bc, sprite2
  call move_sprite
  ld bc, sprite3
  call move_sprite
  ret

handle_press_up:
  ld d, 0x00
  ld e, -0x01
  ld bc, sprite1
  call move_sprite
  ld bc, sprite2
  call move_sprite
  ld bc, sprite3
  call move_sprite
  ret

handle_press_down:
  ld de, 0x0001
  ld bc, sprite1
  call move_sprite
  ld bc, sprite2
  call move_sprite
  ld bc, sprite3
  call move_sprite
  ret

