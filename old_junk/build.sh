z80asm main.asm -o chup.bin && \
# 32768 == 0x8000 \
bin2tap chup.bin chup.tap 32768 && \
open /Applications/Emulators/Fuse.app chup.tap
