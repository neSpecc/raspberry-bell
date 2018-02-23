import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BOARD)
GPIO.setup(7, GPIO.OUT)
print "LED on"
GPIO.output(7, 1)
time.sleep(1)
print "LED off"
GPIO.output(7,0)
GPIO.cleanup()
