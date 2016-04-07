#!/usr/bin/python
from __future__ import print_function
import time
import datetime
import os
import RPi.GPIO as GPIO
import socket
import sys

#PIR Sensor(#555-28027)
#https://www.parallax.com/sites/default/files/downloads/555-28027-PIR-Sensor-Product-Guide-v2.3.pdf

## Raspberry Pi 2 Model B (J8 header)
# 3.3 VDC 1  o    o 2 5.0 VDC (Power) <======
#         3  o    o 4 5.0 VDC
#         5  o    o 6 Ground
#         7  o    o 8
# GND     9  o    o 10
# GEN017 11  o    o 12
# GEN027 13  o    o 14
#            o    o 16 GPIO 23 
#            o    o 18 GPIO 24 
#            o    o

GPIO.setmode(GPIO.BCM)
pir = 27

GPIO.setup(pir, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)

def alarm():
    ts = time.time()
    global last
    st = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')
    if ts - last > 30:
        last = ts
        print(st, "PIR ALARM!", file=sys.stderr)
        if len(sys.argv) > 1:
            addresses = ' '.join([sys.argv[1:]
            cmd = "echo PIR motion detection at " + st + " | mail -s 'motion detected on " + socket.gethostname() + "' " + addresses)
            os.system(cmd)
            print(st, "Sent email to", addresses, file=sys.stderr)
    else:
        print(st, "PIR Alarm Skipped", file=sys.stderr)

last = 0
while True:
    GPIO.wait_for_edge(pir, GPIO.RISING)
    alarm()

GPIO.cleanup()

