import os
import importlib.util
from types import ModuleType

LUMERICAL_DIR = r"/opt/lumerical"

def lumerical_dir():
    versions = os.listdir(LUMERICAL_DIR)
    version = sorted(versions, reverse=True, key=lambda x: x.upper())[0]
    path = os.path.join(LUMERICAL_DIR, version)
    return path

def import_lumapi(path: str = "") -> ModuleType:
    if not path:
        versions = os.listdir(LUMERICAL_DIR)
        version = sorted(versions, reverse=True, key=lambda x: x.upper())[0]
        path = os.path.join(LUMERICAL_DIR, version, "api/python/lumapi.py")
    if not path:
        raise ImportError(f"No lumerical installation found!")
    spec = importlib.util.spec_from_file_location("lumapi", path)
    assert spec is not None, "Could not load 'lumapi' import spec"
    lumapi = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(lumapi)  # type: ignore
    return lumapi

lumapi = import_lumapi()
lumapi_vars = {
    name: value
    for name, value in vars(lumapi).items()
    if not (name.startswith("_") or isinstance(value, type(lumapi)))
}
globals().update(lumapi_vars)
del lumapi_vars
