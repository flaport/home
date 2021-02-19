import os

with open("/etc/environment", "r") as file:
    for line in file:
        try:
            key, val = line.split("=")
        except:
            continue
        os.environ[key.strip()] = val.strip()
