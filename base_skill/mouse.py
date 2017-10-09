import win32api, win32con

def move_mouse(x,y):
    win32api.SetCursorPos((x, y))

def left_click(x,y):
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, x, y, 0, 0)
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, x, y, 0, 0)

def right_click(x, y):
    win32api.mouse_event(win32con.MOUSEEVENTF_RIGHTDOWN, x, y, 0, 0)
    win32api.mouse_event(win32con.MOUSEEVENTF_RIGHTUP, x, y, 0, 0)

def move_click(x, y, side):
    move_mouse(x, y)
    if side =='left':
        left_click(x, y)
    elif side =='right':
        right_click(x,y)

# selection of paragraph of texts
def selection(x,y):
    pass


if __name__ =='__main__':
    left = 600
    bottom = 300

    move_click(left, bottom, 'right')



#995 234 1790 845
#(left, top, right, bottom) = GetWindowRect(hwnd)

# click(left+40,bottom -222)
