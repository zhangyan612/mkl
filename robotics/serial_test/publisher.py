import serial 
import time
SerialData = serial.Serial('/dev/ttyACM0',9600)

while True:
    SerialData.write('1')
    time.sleep(5)