c = get_config()  # noqa

ENABLED = ["pyright"]

LANGUAGE_SERVERS = {
    "relay": {
        "version": 2,
        "argv": ["/Users/flaport/.local/bin/relaylsp"],
        "languages": ["python"],
        "mime_types": ["text/python", "text/ipython"],
        "display_name": "relay",
    },
    "ruff": {
        "version": 2,
        "argv": ["/opt/homebrew/bin/ruff", "server"],
        "languages": ["python"],
        "mime_types": ["text/python", "text/ipython"],
        "display_name": "ruff",
    },
    "pyright": {
        "version": 2,
        "argv": ["/opt/homebrew/bin/pyright-langserver", "--stdio"],
        "languages": ["python"],
        "mime_types": ["text/python", "text/ipython"],
        "display_name": "pyright",
    },
}

c.ServerApp.open_browser = False
c.LanguageServerManager.autodetect = False
c.LanguageServerManager.language_servers = {
    k: v for k, v in LANGUAGE_SERVERS.items() if k in ENABLED
}

c.ServerApp.token = ""  # disable token auth
