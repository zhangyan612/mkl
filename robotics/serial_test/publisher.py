# import serial 
# import time
# SerialData = serial.Serial('/dev/ttyACM0',9600)

# while True:
#     SerialData.write('1')
#     time.sleep(5)



import arduinoserial

arduino = arduinoserial.SerialPort('/dev/ttyACM0', 9600)
print arduino.read_until('\n')
arduino.write('a5050')