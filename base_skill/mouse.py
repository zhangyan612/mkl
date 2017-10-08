import win32api, win32con

def move_mouse(x,y):
    win32api.SetCursorPos((x, y))

def left_click(x,y):
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, x, y, 0, 0)
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, x, y, 0, 0)

def right_click(x, y):
    win32api.mouse_event(win32con.MOUSEEVENTF_RIGHTDOWN, x, y, 0, 0)
    win32api.mouse_event(win32con.MOUSEEVENTF_RIGHTUP, x, y, 0, 0)

def move_click(x,y):
    move_mouse(x,y)
    # left_click(x,y)
    right_click(x,y)

# selection of paragraph of texts
def selection(x,y):
    pass


#995 234 1790 845
#(left, top, right, bottom) = GetWindowRect(hwnd)

left = 600
bottom = 300

move_click(left,bottom)
# click(left+40,bottom -222)
