import RPi.GPIO as GPIO
import time

def bing():
  GPIO.setmode(GPIO.BOARD)
  GPIO.setwarnings(False)
  GPIO.setup(7,GPIO.OUT)
  print "Solenoid on"
  GPIO.output(7,1)
  time.sleep(1)
  print "Solenoid off"
  GPIO.output(7,0)
  GPIO.cleanup()
if __name__ == '__main__':
    bing()
