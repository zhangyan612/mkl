# able to take screen capture
# or be able to monitor screen in real time
#
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

import numpy as np
import cv2
from mss import mss
from PIL import Image

mon = {'top': 160, 'left': 160, 'width': 200, 'height': 200}

sct = mss()
help(sct)

# while 1:
#     sct.get_pixels(mon)
#     img = Image.frombytes('RGB', (sct.width, sct.height), sct.image)
#     cv2.imshow('test', np.array(img))
#     if cv2.waitKey(25) & 0xFF == ord('q'):
#         cv2.destroyAllWindows()
#         break
