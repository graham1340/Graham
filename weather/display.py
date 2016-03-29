#!/usr/bin/env python
import MAX7219array as m7219
from MAX7219fonts import CP437_FONT, SINCLAIRS_FONT, LCD_FONT, TINY_FONT
from MAX7219array import DIR_L, DIR_R, DIR_U, DIR_D
import sys
import time
import fileinput

for line in sys.stdin:
    m7219.init()
    m7219.brightness(1)
    m7219.scroll_message_horiz(line.rstrip(), 1, 7, DIR_L, CP437_FONT)
    m7219.clear_all()
    #print(line)
