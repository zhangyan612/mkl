import serial 
import time
SerialData = serial.Serial('/dev/ttyACM0',9600)

while True:
    SerialData.write('20,90,90,90,90,90,73')
    time.sleep(5)



# import arduinoserial

# arduino = arduinoserial.SerialPort('/dev/ttyACM0', 9600)
# print arduino.read_until('\n')
# arduino.write('5,22,12')