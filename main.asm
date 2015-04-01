org 0x8000

pos_x: defb 0
pos_y: defb 0


main:
  ;call clear_screen
  ; Sprite X
  ld a, 32
  ld (pos_x), a
  ; Sprite Y
  ld a, 32
  ld (pos_y), a

  call draw_char
  ret
  ;ld b, 192


; Draw black square at pos_x/pos_y
draw_char:
  call pixel_address
  ; draw all 8 rows
  ld b, 8
  draw_char_loop:
    call draw_pixels
    ld a, d
    add a, 1
    ld d, a
    djnz draw_char_loop

  ret


draw_pixels:
  ; Copy character to accumulator
  ld a, (de)

  ; Write pixels to accumulator
  xor %11111111

  ; Copy updated char back to screen
  ld (de), a

  ret


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
  ld hl, 0x4000 ; Start of screen
  ld de, 0x4001
  ld bc, 0x1800 ; Size of screen
  ld (hl), 0
  ldir
  ld bc, 0x02ff
  ld (hl), a
  ldir
  ret

done:
  ret



sprite_1:
  defw %0100010100010100
  defw %0111111111111110
  defw %1000000000000001
  defw %0011100000011100
  defw %0111110000111110
  defw %0011100000011100
  defw %0000000000000000
  defw %0000000100000000
  defw %0000001110000000
  defw %0000011111000000
  defw %0000001110000000
  defw %0000000000000000
  defw %0011100000011100
  defw %0001000000001000
  defw %0000111111110000
  defw %0000000000000000


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

loop:
  push bc

  ld b, 31
  call pixel_address
  inner_loop:
    push bc

    call draw_pixels
    call inc_x

    inc de ; increment pixel
    pop bc
    djnz inner_loop

  call reset_x
  call inc_y

  pop bc
  djnz loop
  jp done

reset_x:
  ld a, 0
  ld (pos_x), a
  ret

reset_y:
  ld a, 0
  ld (pos_y), a
  ret

inc_x:
  ld hl, (pos_x)
  ld bc, 8
  add hl, bc
  ld (pos_x), hl
  ret

inc_y:
  ld hl, (pos_y)
  ld bc, 1
  add hl, bc
  ld (pos_y), hl
  ret


