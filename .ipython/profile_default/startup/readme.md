# IPython Startup

This is the IPython startup directory

`.py` and `.ipy` files in this directory will be run _prior_ to any code or files specified
via the exec_lines or exec_files configurables whenever you load this profile.

Files will be run in lexicographical order, so you can control the execution order of files
with a prefix, e.g.::

```
    00-first.py
    50-middle.py
    99-last.ipy
```

## Files in this folder:

- [00_pythonpath.py](00_pythonpath.py): reads `~/.pythonpath` and prepends it to `sys.path`.
- [01_pythonstartup.py](01_pythonstartup.py): lazily import 3rd party libraries.
- [02_environment.py](02_environment.py): read content from `/etc/environment` and add
  it to `os.environ`.
