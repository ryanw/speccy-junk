z80asm main.asm -o scroller.bin && \
# 32768 == 0x8000 \
bin2tap scroller.bin scroller.tap 32768
echo "Built to scroller.tap"
