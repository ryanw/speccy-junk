org 0x8000

pos_x: defb 0
pos_y: defb 0
tmp_0: defb 0


main:
  call clear_screen
  ; Sprite X
  ld a, 64
  ld (pos_x), a
  ; Sprite Y
  ld a, 0
  ld (pos_y), a


  call draw_char
  main_loop:
    halt
    call draw_char
    ld a, (pos_y)
    inc a
    ld (pos_y), a
    call draw_char
    jr main_loop
  ret

; Draw Sprite!
draw_char:
  push bc
  call pixel_address
  ; Pixel address is now in DE

  ld a, (pos_y)
  ld (tmp_0), a

  ld hl, sprite_1
  ; draw all 8 rows
  ld b, 16
  draw_char_loop:

    ; source is HL
    ; dest is DE
    ld a, (de)
    xor (hl)
    ld (de), a

    inc hl
    inc de
    ld a, (de)
    xor (hl)
    ld (de), a

    dec de


    inc hl


    ld a, (tmp_0)
    inc a
    ld (tmp_0), a
    and 7
    jr z, draw_char_next_row

    inc d


    djnz draw_char_loop

draw_char_done:
  pop bc
  ret

draw_char_next_segment:
  djnz draw_char_loop

draw_char_next_row:
  ex de, hl
  push de
  ld de, -1760
  ;inc e
  add hl, de

  pop de
  ex de, hl
  djnz draw_char_loop
  jr draw_char_done


; Read pixel coord from pos_x/pos_y and store address in (de)
pixel_address:
  xor a               ; clear carry flag and accumulator.
  ld d,a              ; empty de high byte.
  ld a,(pos_y)        ; y position.
  rla                 ; shift left to multiply by 2.
  ld e,a              ; place this in low byte of de pair.
  rl d                ; shift top bit into de high byte.
  ld hl,row_offsets   ; table of screen addresses.
  add hl,de           ; point to table entry.
  ld e,(hl)           ; low byte of screen address.
  inc hl              ; point to high byte.
  ld d,(hl)           ; high byte of screen address.
  ld a,(pos_x)        ; horizontal position.
  rra                 ; divide by two.
  rra                 ; and again for four.
  rra                 ; shift again to divide by eight.
  and 31              ; mask away rubbish shifted into rightmost bits.
  add a,e             ; add to address for start of line.
  ld e,a              ; new value of e register.
  ret                 ; return with screen address in de.

clear_screen:
  ; Set borders to black
  ld a, 0
  call 0x229B

  ; Clear pixels
  ld hl, 0x4000 ; Copy first screen byte...
  ld de, 0x4001 ; ... into next screen byte
  ld bc, 0x17FF ; ... for length of pixel memory
  ld (hl), 0  ; Manually clear first screen byte
  ldir  ; Do the copy

  ; Clear attributes/colours
  ld a, %000111 ; Colour to clear with
  ld bc, 0x02ff  ; Size of attribute memory
  ld (hl), a
  ldir
  ret

done:
  ret

random:
  ld hl,(seed)        ; Pointer
  ld a,h
  and 31              ; keep it within first 8k of ROM.
  ld h,a
  ld a,(hl)           ; Get "random" number from location.
  inc hl              ; Increment pointer.
  ld (seed),hl
  ret
seed: defw 0

sprite_2:
  defb %00000111
  defb %00011000
  defb %00100000
  defb %01001110
  defb %01011111
  defb %10011111
  defb %10001110
  defb %10000000

sprite_1:
  defb %00000111, %11100000
  defb %00011000, %00011000
  defb %00100000, %00000100
  defb %01001110, %00000010
  defb %01011111, %00000010
  defb %10011111, %00000001
  defb %10001110, %00000001
  defb %10000000, %00000001
  defb %10000000, %00000001
  defb %10000000, %00000001
  defb %10000000, %00011001
  defb %01000000, %00111010
  defb %01000000, %00110010
  defb %00100000, %00000100
  defb %00011000, %00011000
  defb %00000111, %11100000


row_offsets:
  defw 16384
  defw 16640
  defw 16896
  defw 17152
  defw 17408
  defw 17664
  defw 17920
  defw 18176
  defw 16416
  defw 16672
  defw 16928
  defw 17184
  defw 17440
  defw 17696
  defw 17952
  defw 18208
  defw 16448
  defw 16704
  defw 16960
  defw 17216
  defw 17472
  defw 17728
  defw 17984
  defw 18240
  defw 16480
  defw 16736
  defw 16992
  defw 17248
  defw 17504
  defw 17760
  defw 18016
  defw 18272
  defw 16512
  defw 16768
  defw 17024
  defw 17280
  defw 17536
  defw 17792
  defw 18048
  defw 18304
  defw 16544
  defw 16800
  defw 17056
  defw 17312
  defw 17568
  defw 17824
  defw 18080
  defw 18336
  defw 16576
  defw 16832
  defw 17088
  defw 17344
  defw 17600
  defw 17856
  defw 18112
  defw 18368
  defw 16608
  defw 16864
  defw 17120
  defw 17376
  defw 17632
  defw 17888
  defw 18144
  defw 18400
  defw 18432
  defw 18688
  defw 18944
  defw 19200
  defw 19456
  defw 19712
  defw 19968
  defw 20224
  defw 18464
  defw 18720
  defw 18976
  defw 19232
  defw 19488
  defw 19744
  defw 20000
  defw 20256
  defw 18496
  defw 18752
  defw 19008
  defw 19264
  defw 19520
  defw 19776
  defw 20032
  defw 20288
  defw 18528
  defw 18784
  defw 19040
  defw 19296
  defw 19552
  defw 19808
  defw 20064
  defw 20320
  defw 18560
  defw 18816
  defw 19072
  defw 19328
  defw 19584
  defw 19840
  defw 20096
  defw 20352
  defw 18592
  defw 18848
  defw 19104
  defw 19360
  defw 19616
  defw 19872
  defw 20128
  defw 20384
  defw 18624
  defw 18880
  defw 19136
  defw 19392
  defw 19648
  defw 19904
  defw 20160
  defw 20416
  defw 18656
  defw 18912
  defw 19168
  defw 19424
  defw 19680
  defw 19936
  defw 20192
  defw 20448
  defw 20480
  defw 20736
  defw 20992
  defw 21248
  defw 21504
  defw 21760
  defw 22016
  defw 22272
  defw 20512
  defw 20768
  defw 21024
  defw 21280
  defw 21536
  defw 21792
  defw 22048
  defw 22304
  defw 20544
  defw 20800
  defw 21056
  defw 21312
  defw 21568
  defw 21824
  defw 22080
  defw 22336
  defw 20576
  defw 20832
  defw 21088
  defw 21344
  defw 21600
  defw 21856
  defw 22112
  defw 22368
  defw 20608
  defw 20864
  defw 21120
  defw 21376
  defw 21632
  defw 21888
  defw 22144
  defw 22400
  defw 20640
  defw 20896
  defw 21152
  defw 21408
  defw 21664
  defw 21920
  defw 22176
  defw 22432
  defw 20672
  defw 20928
  defw 21184
  defw 21440
  defw 21696
  defw 21952
  defw 22208
  defw 22464
  defw 20704
  defw 20960
  defw 21216
  defw 21472
  defw 21728
  defw 21984
  defw 22240
  defw 22496

