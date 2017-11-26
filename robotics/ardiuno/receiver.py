import serial 
SerialData = serial.Serial('/dev/ttyACM0',9600)

while True:
      if SerialData.inWaiting():
            myData = SerialData.readline()
            print myData




# from nanpy import Arduino
# from nanpy import serial_manager
# serial_manager.connect('/dev/ttyACM0')    	 # serial connection to Arduino
# from time import sleep

# LED =10                     	# LED on Arduino Pin 10 (with PWM)
# Arduino.pinMode(LED, Arduino.OUTPUT)


# from nanpy import Arduino
# from nanpy import serial_manager
# serial_manager.connect('/dev/ttyACM0')     # serial connection to Arduino
# from time import sleep
# from nanpy import Lcd
# lcd = Lcd([7,6,5,4,3,2], [16,2])  # Set up LCD - Digital output

# button = 8                   # Button switch on pin 8
# LED = 10                     # LED on Arduino Pin 10 (with PWM - analog output)
# pot = 14                     # Pot on A0 - Analog input

# Arduino.pinMode(button, Arduino.INPUT)# Set Button pin for input
# Arduino.pinMode(LED, Arduino.OUTPUT)  # Set LED pin for output
# print"Starting"
# lcd.printString("LCD Demo", 0, 0)     # message on LCD line 1
# sleep(2.5)
# sw = Arduino.digitalRead(button)      # Get open value of switch

# sw1 = Arduino.digitalRead(button)     # digital input
# lcd.printString("Press button", 0, 0)
# while (sw1 == sw):                     #Wait until switch is pressed
#     sw1 = Arduino.digitalRead(button)

# lcd.printString("Turn LEFT POT", 0, 0)

# print"Turn the pot - Analogue input - 10 bit"
# for i in range(0,25):
#     val = Arduino.analogRead(pot)     # Analog input
#     print val
#     lcd.printString(val, 0, 1)
#     lcd.printString("     ")
#     sleep(0.3)

# lcd.printString("      ", 0, 1)      # message on LCD line 2
# lcd.printString("Flash LED x5   ", 0,0)

# print"Flash the LED 5 times - Digital output"
# for i in range(0,5):
#     lcd.printString(i+1, 0 , 1)      # Count flashes on LCD
#     Arduino.digitalWrite(LED, Arduino.HIGH)  # LED on
#     sleep(0.5)
#     Arduino.digitalWrite(LED, Arduino.LOW)   # LED off
#     sleep(0.5)
# lcd.printString("        ", 0 ,1)

# lcd.printString("LED brightness", 0 ,0)
# print"Changing brightness of LED"
# bright = 80                          # Set to mid brightness
# Arduino.analogWrite(LED, bright)     # Turn on LED at power = brightness

# for i in range(0,110):
#     bright = bright + 10
#     if (bright > 180):               # LED at full brightness
#         bright = 0
#     Arduino.analogWrite(LED, bright)
#     sleep(0.2)

# Arduino.digitalWrite(LED,Arduino.LOW)       # Turn off LED

# print"Turn the pot - Analogue input - 10 bit"
# print"Control brightness of LED"
# lcd.printString("Turn LEFT POT   ", 0, 0)
# lcd.printString("         ", 0, 1)

# for i in range(0,50):
#     val = Arduino.analogRead(pot)
#     bright = val/5                 # Scale down analog value
#     print val, bright
#     lcd.printString(val, 0,1)
#     Arduino.analogWrite(LED, bright)  #Set LED brightness
#     sleep(0.1)
#     lcd.printString("     ", 0, 1)

# Arduino.digitalWrite(LED, Arduino.LOW)     # Turn off LED
# print"Finished"
# lcd.printString("Finished        ", 0,0)
# lcd.printString("      ",0,1)
# sleep(2.5)
# lcd.printString("           ", 0,0)        # Clear LCD screen