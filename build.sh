echo
z80asm src/main.asm -I src -o scroller.bin && \
# 32768 == 0x8000 \
bin2tap scroller.bin scroller.tap 32768 && echo "Built to scroller.tap"
