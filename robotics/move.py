import RPi.GPIO as gpio
import time

def init():
    gpio.setmode(gpio.BCM)
    gpio.setup(17, gpio.OUT)
    gpio.setup(22, gpio.OUT)
    gpio.setup(23, gpio.OUT)
    gpio.setup(24, gpio.OUT)

def reverse(tf):
    init()
    gpio.output(17, True)
    gpio.output(22, False)
    gpio.output(23, True) 
    gpio.output(24, False)
    time.sleep(tf)
    gpio.cleanup()

def forward(tf):
    init()
    gpio.output(17, False)
    gpio.output(22, True)
    gpio.output(23, False)
    gpio.output(24, True)
    time.sleep(tf)
    gpio.cleanup()

 def left(tf):
    init()
    gpio.output(17, True)
    gpio.output(22, True)
    gpio.output(23, False)
    gpio.output(24, False)
    time.sleep(tf)
    gpio.cleanup()

 def right(tf):
    init()
    gpio.output(17, False)
    gpio.output(22, False)
    gpio.output(23, True)
    gpio.output(24, True)
    time.sleep(tf)
    gpio.cleanup()


 def stop():
    gpio.output(Motor1E,gpio.LOW)
    gpio.output(Motor2E,gpio.LOW)


forward(1)
reverse(1)
left(1)
right(1)
stop()