import RPi.GPIO as GPIO
import time

def bing():
    GPIO.setmode(GPIO.BOARD)
    GPIO.setwarnings(False)
    GPIO.setup(7,GPIO.OUT)
    print "Servo ON"
    GPIO.output(7,1)
    time.sleep(3)
    print "Servo OFF"
    GPIO.output(7,0)
    GPIO.cleanup()
if name == 'main':
    bing()
