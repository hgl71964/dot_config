import sys
import time
print(sys.path)

def display():
    i = 0
    while (i<1000):
        print(i)
        time.sleep(20)
        i+=1

