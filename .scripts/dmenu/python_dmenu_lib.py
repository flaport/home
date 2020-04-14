#!/usr/bin/python3
#    _____ _     ____  ____  ____  ____  _____
#   /    // \   /  _ \/  __\/  _ \/  __\/__ __\
#   |  __\| |   | / \||  \/|| / \||  \/|  / \
#   | |   | |_/\| |-|||  __/| \_/||    /  | |
#   \_/   \____/\_/ \|\_/   \____/\_/\_\  \_/
#

# imports
import os
import sys
import time
from subprocess import Popen, call, check_output, PIPE, CalledProcessError
try:
    import pyautogui
except:
    pyautogui = None
display = os.environ.get("DISPLAY")
with open(os.devnull, "w") as out:
    has_xdotool = display and not call(["which", "xdotool"], stdout=out, stderr=out)

# functions
def dmenu(list_in, prompt=""):
    prompt = [] if not prompt else ["-p", prompt]
    try:
        dmenu_in = Popen(["echo", "\n".join(list_in)], stdout=PIPE).stdout
        choice = check_output(
            ["dmenu"] + prompt + sys.argv[2:], stdin=dmenu_in
        ).decode().strip()
        return choice
    except CalledProcessError:
        return ""

def notify(title, message=""):
    if display:
        if message:
            check_output(["notify-send", title, message])
        else:
            check_output(["notify-send", title])

def copy_to_clipboard(content):
    if display:
        xclip_in = Popen(["echo", "-n", content], stdout=PIPE).stdout
        status = call(["xclip", "-selection", "primary"], stdin=xclip_in)
        xclip_in = Popen(["echo", "-n", content], stdout=PIPE).stdout
        status = call(["xclip", "-selection", "clipboard"], stdin=xclip_in)
        return status

def get_dict(filename):
    filename = os.path.abspath(os.path.expanduser(filename))
    dic = {}
    with open(filename, "r") as file:
        for line in file:
            value, key = line.split(" ")
            value = value.strip()
            key = key.strip()
            longkey = f"{key} {value}"
            dic[longkey] = value
    return dic

def get_current_window_name_and_position():
    if not has_xdotool:
        return "", 0, 0
    window_id = check_output(["xdotool", "getactivewindow"]).strip().decode()
    name = check_output(["xdotool", "getwindowname", window_id]).strip().decode()
    geometry = check_output(["xdotool", "getwindowgeometry", window_id]).strip().decode()
    x, y = geometry.split("Position: ")[1].split(" ")[0].split(",")
    return name, x, y

def move_mouse(x, y):
    if not has_xdotool:
        return 1
    return call(["xdotool", "mousemove", x, y])

def middle_click():
    if not has_xdotool:
        return 1
    return call(["xdotool", "click", "2"])

def paste(windowname, content):
    if pyautogui is not None and not windowname in {"st", "xterm", "urxvt"}:
        pyautogui.hotkey("ctrl", "v")
    elif has_xdotool:
        middle_click()
    elif display:
        notify(f"'{content}' copied to clipboard.")
    else:
        print(content)

def main(get_dict, *args):
    try:
        dic = get_dict()
        windowname, x, y = get_current_window_name_and_position()
        name = dmenu(dic.keys(), *args)
        ret = dic.get(name, "")
        if ret:
            copy_to_clipboard(ret)
            move_mouse(x, y)
            paste(windowname, ret)
        return 0
    except:
        return 1

