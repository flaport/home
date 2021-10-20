import os

with open("/etc/environment", "r") as __file:
    for __line in __file:
        try:
            __key, __val = __line.split("=")
        except:
            continue
        os.environ[__key.strip()] = __val.strip()

if not "DISPLAY" in os.environ:
    os.environ["DISPLAY"] = ":0"

del __file, __key, __val, __line, os
