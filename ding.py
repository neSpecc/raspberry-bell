import RPi.GPIO as GPIO
import time

def bing():
    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(False)
    GPIO.setup(18,GPIO.OUT)
    print "Servo ON"
    GPIO.output(18,GPIO.HIGH)
    time.sleep(1)
    print "Servo OFF"
    GPIO.output(18,GPIO.LOW)
if name == 'main':
    bing()
