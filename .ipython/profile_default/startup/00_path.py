# this file adds ~/.pythonpath to the python path in jupyter/ipython
# the same is also implemented in ~/.bashrc, such that ~/.pythonpath
# is also available in normal python.
import sys
from os.path import expanduser as __expand
from sys import path as __path
with open(__expand('~/.pythonpath'), 'r') as __file:
    __pth = __file.readlines()
for __p in __pth:
    __path.insert(0, __expand(__p.strip()))
del __expand, __path, __file, __pth
