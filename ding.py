import RPi.GPIO as GPIO
import time

def bing():
  GPIO.setmode(GPIO.BCM)
  GPIO.setwarnings(False)
  GPIO.setup(18,GPIO.OUT)
  print("Solenoid on")
  GPIO.output(18,1)
  time.sleep(0.1)
  print("Solenoid off")
  GPIO.output(18,0)
  GPIO.cleanup()
if __name__ == '__main__':
    bing()
