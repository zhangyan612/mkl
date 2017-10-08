# able to take screen capture
# or be able to monitor screen in real time

import numpy as np
import cv2
from PIL import ImageGrab
from win32api import GetSystemMetrics

def screen_size():
    width = GetSystemMetrics(0)
    height = GetSystemMetrics(1)
    return width, height

def screen_recording():
    width, height = screen_size()
    fourcc = cv2.VideoWriter_fourcc('X','V','I','D') #you can use other codecs as well.
    vid = cv2.VideoWriter('record.avi', fourcc, 8, (width,height))

    while(True):
        img = ImageGrab.grab(bbox=(0, 0, width, height)) #x, y, w, h
        img_np = np.array(img)
        #frame = cv2.cvtColor(img_np, cv2.COLOR_BGR2GRAY)
        vid.write(img_np)
        cv2.imshow("frame", img_np)
        key = cv2.waitKey(1)
        if key == 27:
            break
    vid.release()
    cv2.destroyAllWindows()

# screen_size()
screen_recording()
# import cv2
#
# cap = cv2.VideoCapture(0)
# while(cap.isOpened()):
#     ret, frame = cap.read()
#     cv2.imshow('WindowName', frame)
#     if cv2.waitKey(25) & 0xFF == ord('q'):
#         cap.release()
#         cv2.destroyAllWindows()
#         break


# import numpy as np
# from PIL import ImageGrab
# import cv2
#
# while(True):
#     printscreen_pil = ImageGrab.grab()
#     printscreen_numpy = np.array(printscreen_pil.getdata(),dtype='uint8')\
#     .reshape((printscreen_pil.size[1],printscreen_pil.size[0],3))
#     cv2.imshow('window',printscreen_numpy)
#     if cv2.waitKey(25) & 0xFF == ord('q'):
#         cv2.destroyAllWindows()
#         break