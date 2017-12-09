# from gopigo import *	#Has the basic functions for controlling the GoPiGo Robot
import sys	#Used for closing the running program
# import move
import motor_test as move
import time
# t: Increase speed\n\tg: Decrease speed\n\t

print("Press:\n\tw: Move Robot forward\n\ta: Turn Robot left\n\td: Turn Robot right\n\ts: Move Robot backward\n\tx: Stop  Robot\n\tz: Exit\n")
while True:
	a=input("Enter the Command:")	# Fetch the input from the terminal
	if a=='w':
		move.fwd()	# Move forward
	elif a=='a':
		move.turn_left()	# Turn left
	elif a=='d':
		move.turn_right()	# Turn Right
	elif a=='s':
		move.back()	# Move back
	elif a=='x':
		move.stop()	# Stop
	# elif a=='t':
	# 	increase_speed()	# Increase speed
	# elif a=='g':
	# 	decrease_speed()	# Decrease speed
	elif a=='z':
		print("Exiting")	# Exit
		sys.exit()
	else:
		print("Wrong Command, Please Enter Again")
	time.sleep(.1)
