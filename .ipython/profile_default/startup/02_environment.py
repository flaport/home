import os

with open("/etc/environment", "r") as __file:
    for line in __file:
        try:
            __key, __val = line.split("=")
        except:
            continue
        os.environ[__key.strip()] = __val.strip()


del __file, __key, __val
