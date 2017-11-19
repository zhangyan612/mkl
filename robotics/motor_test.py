from gpiozero import PWMOutputDevice
from time import sleep

left_motor = PWMOutputDevice(4)
right_motor = PWMOutputDevice(17)

while True:
  left_motor.on()
  right_motor.on()
  sleep(1)
  left_motor.off()
  right_motor.off()
#   sleep(1)
#   pwm.value = 0.5
#   sleep(1)
#   pwm.value = 0.0
#   sleep(1)