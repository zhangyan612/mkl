# from gopigo import *	#Has the basic functions for controlling the GoPiGo Robot
import sys	#Used for closing the running program
import move
print("Press:\n\tw: Move Robot forward\n\ta: Turn Robot left\n\td: Turn Robot right\n\ts: Move Robot backward\n\tt: Increase speed\n\tg: Decrease speed\n\tx: Stop  Robot\n\tz: Exit\n")
while True:
	print "Enter the Command:",
	a=raw_input()	# Fetch the input from the terminal
	if a=='w':
		forward(1)	# Move forward
	elif a=='a':
		left()	# Turn left
	elif a=='d':
		right()	# Turn Right
	elif a=='s':
		reverse()	# Move back
	elif a=='x':
		stop()	# Stop
	# elif a=='t':
	# 	increase_speed()	# Increase speed
	# elif a=='g':
	# 	decrease_speed()	# Decrease speed
	elif a=='z':
		print("Exiting")		# Exit
		sys.exit()
	else:
		print("Wrong Command, Please Enter Again")
	time.sleep(.1)
