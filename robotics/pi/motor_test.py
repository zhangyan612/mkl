from gpiozero import PWMOutputDevice
from time import sleep

left_motor = PWMOutputDevice(4)
right_motor = PWMOutputDevice(17)

#   sleep(1)
#   pwm.value = 0.5
#   sleep(1)
#   pwm.value = 0.0
#   sleep(1)

def fwd():
  left_motor = PWMOutputDevice(4)
  right_motor = PWMOutputDevice(17)

def turn_left():
  left_motor = PWMOutputDevice(4)
  right_motor.off()

def turn_right():
  left_motor.off()
  right_motor = PWMOutputDevice(17)

def stop():
  left_motor.off()
  right_motor.off()

def back():
  print('cannot turn back yet')



if __name__ == "__main__":
  # while True:
  left_motor.on()
  right_motor.on()
  sleep(1)
  left_motor.off()
  right_motor.off()
