CODE_START_ADDR: equ 0x8000
PIXELS_ADDR: equ 0x4000
COLOURS_ADDR: equ 0x5800
COLOURS_LEN: equ 0x02FF
PIXELS_LEN: equ 0x1800

SET_BORDER: equ 0x229B
PRINT_STRING: equ 0x203C
OPEN_CHANNEL: equ 0x1601

UPPER_SCREEN: equ 0x02

KSTATE: equ 0x5C00
LAST_K: equ 0x5C08

SCREEN_TOP: equ 0x40
SCREEN_MID: equ 0x48
SCREEN_BOT: equ 0x50

KEYS_MNB: equ 0x7FFE ; sym shift + space
KEYS_LKJH: equ 0xBFFE ; enter
KEYS_POIUY: equ 0xDFFE
KEYS_67890: equ 0xEFFE
KEYS_54321: equ 0xF7FE
KEYS_QWERT: equ 0xFBFE
KEYS_ASDFG: equ 0xFDFE
KEYS_ZXCV: equ 0xFEFE ; caps shift

KEY_P: equ %00001000
KEY_O: equ %00010000
KEY_Q: equ %00010000
KEY_A: equ %00010000

; Colours
FG_BLACK:  equ %00000000
FG_BLUE:   equ %00000001
FG_RED:    equ %00000010
FG_PINK:   equ %00000011
FG_GREEN:  equ %00000100
FG_CYAN:   equ %00000101
FG_YELLOW: equ %00000110
FG_WHITE:  equ %00000111

BG_BLACK:  equ %00000000
BG_BLUE:   equ %00001000
BG_RED:    equ %00010000
BG_PINK:   equ %00011000
BG_GREEN:  equ %00100000
BG_CYAN:   equ %00101000
BG_YELLOW: equ %00110000
BG_WHITE:  equ %00111000

BRIGHT:    equ %01000000
FLASH:     equ %10000000

