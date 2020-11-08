""" smdv: the simple markdown viewer"""
__version__ = "0.2.0"
__author__ = "Floris Laporte"


import io
import os
import re
import sys
import json
import socket
import pathlib
import asyncio
import argparse
import threading
import subprocess
import webbrowser
import contextlib

import flask
import jinja2
import websockets


# globals
root = pathlib.Path("/")
home = pathlib.Path("~").expanduser()
here = pathlib.Path(__file__).parents[0]
eventloop = asyncio.get_event_loop()
state = {"content": "", "path": str(pathlib.Path(".").absolute())}
last_file_message = {}
clients = set()
html_meta = """
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
"""
navbar = """
<div id="navbar">
<span id="closeFile" onclick="closeFile()" style="float: right; cursor: pointer;"></span>
</div>
"""

# default arguments
host = "localhost"
port = 9876
ws_host = "localhost"
ws_port = 9877
nvim_address = "localhost:9878"
filename = pathlib.Path("")
browser = os.environ.get("BROWSER")
html_template = here / "smdv.html"
no_browser = False
stdin = False
debug = False


def parse_args(args):
    parser = argparse.ArgumentParser(description="smdv: the simple markdown viewer")
    parser.add_argument(
        "filename",
        type=str,
        nargs="?",
        default=filename,
        help="path or file to open with smdv",
    )
    address_group = parser.add_mutually_exclusive_group()
    address_group.add_argument(
        "-a",
        "--address",
        default=f"http://{host}:{port}",
        help=f"address of the form <host>:<port> where smdv will be accessible in a browser (default: http://{host}:{port}, mutually exclusive with --port)",
    )
    address_group.add_argument(
        "-p",
        "--port",
        default="",
        help=f"port on localhost where smdv will be accessible in the browser (default: {port}, mutually exclusive with --address)",
    )
    ws_address_group = parser.add_mutually_exclusive_group()
    ws_address_group.add_argument(
        "-w",
        "--ws-address",
        default=f"{ws_host}:{ws_port}",
        help=f"address of the form <host>:<port> where smdv will set up websocket communication (default: {ws_host}:{ws_port}, mutually exclusive with --ws-port)",
    )
    ws_address_group.add_argument(
        "-P",
        "--ws-port",
        default="",
        help=f"port on localhost where smdv will set up websocket communication (default: {ws_port}, mutually exclusive with --ws-address).",
    )
    nvim_address_group = parser.add_mutually_exclusive_group()
    nvim_address_group.add_argument(
        "-v",
        "--nvim-address",
        default=nvim_address,
        help=f"address of the form <host>:<port> OR a unix socket location like '/tmp/nvimXyZabC/0' of the active neovim instance to communicate with (default: {nvim_address}, mutually exclusive with --nvim-port)",
    )
    nvim_address_group.add_argument(
        "-V",
        "--nvim-port",
        default="",
        help=f"port on localhost of the active neovim instance to communicate with (default: {nvim_address.split(':')[1]}, mutually exclusive with --nvim-address).",
    )
    parser.add_argument(
        "-b",
        "--browser",
        default=browser,
        help="default browser to spawn (uses $BROWSER by default)",
    )
    parser.add_argument(
        "-B",
        "--no-browser",
        action="store_true",
        default=no_browser,
        help="start the server without opening a browser",
    )
    parser.add_argument(
        "-t",
        "--html-template",
        default=str(html_template),
        help=f"html template file to use (default template file: '{str(html_template)}')",
    )
    parser.add_argument(
        "--stdin",
        action="store_true",
        default=stdin,
        help="read content for smdv from stdin",
    )
    parser.add_argument(
        "--debug",
        action="store_true",
        default=debug,
        help=(
            "print exceptions and error messages to stderr. "
            "note that this does NOT run the flask server in debug mode."
        ),
    )
    args = parser.parse_args(args=args)
    args.filename = pathlib.Path(args.filename).absolute()
    args.html_template = pathlib.Path(args.html_template).absolute()
    if args.port:
        args.address = f"http://localhost:{args.port}"
    if args.ws_port:
        args.ws_address = f"localhost:{args.ws_port}"
    if args.nvim_port:
        args.nvim_address = f"localhost:{args.nvim_port}"
    args.address = args.address.strip()
    args.ws_address = args.ws_address.strip()
    args.nvim_address = args.nvim_address.strip()
    if not args.filename.exists():
        raise ValueError(f"file {args.filename} does not exist.")
    if not args.html_template.exists():
        raise ValueError(f"html template {args.html_template} does not exist.")
    if args.address.startswith("https://"):
        raise ValueError("serving smdv over https is not supported")
    if args.ws_address.startswith("https://"):
        raise ValueError("websocket communication for smdv over https is not supported")
    if args.address.startswith("http://"):
        args.address = args.address[7:]
    if args.ws_address.startswith("http://"):
        args.ws_address = args.ws_address[7:]
    args = args.__dict__
    try:
        args["host"], args["port"] = args["address"].split(":")
        args["port"] = int(args["port"])
    except ValueError:
        args["host"], args["port"] = args["address"], 80
    try:
        args["ws_host"], args["ws_port"] = args["ws_address"].split(":")
        args["ws_port"] = int(args["ws_port"])
    except ValueError:
        args["ws_host"], args["ws_port"] = args["ws_address"], 80

    return args


@contextlib.contextmanager
def nostdout():
    oldstdout, oldstderr = sys.stdout, sys.stderr
    try:
        file = open(os.devnull, "w")
        if not debug:
            sys.stdout, sys.stderr = file, file
        yield
    finally:
        sys.stdout, sys.stderr = oldstdout, oldstderr
        file.close()


def create_app():
    """flask app factory

    Returns:
        app: the flask app

    """

    app = flask.Flask(
        __name__,
        template_folder=str(html_template.parents[0]),
        static_folder=str(home),
        static_url_path="/_static",
    )

    @app.route("/<path:path>", methods=["GET"])
    def view(path) -> str:
        if not path.startswith("~"):
            path = f"/{path}"
        path = pathlib.Path(path).expanduser().absolute()
        if not path.exists():
            path = pathlib.Path(f"{path}.md")
        if not path.exists():
            return flask.abort(404)
        if not path.is_dir() and is_binary_file(path):
            # static folders files are relative to home folder (otherwise it doesn't work)
            return flask.redirect(
                flask.url_for("static", filename=path.relative_to(home)), 308
            )
        message = {
            "path": str(path),
            "put": bool(int(flask.request.args.get("put", 0))),  # 'put=1' flag in url
        }
        eventloop.run_until_complete(put(message))
        return flask.redirect("/", 303)

    @app.route("/", methods=["GET", "PUT", "DELETE"])
    def index() -> str:

        if flask.request.method == "GET":
            if flask.request.args.get("root"):
                return view("/")
            html = render_template()
            return html

        if flask.request.method == "PUT":
            # echo content | curl -X PUT -T - http://localhost:9876
            message = flask.request.data.decode()
            try:
                eventloop.run_until_complete(put(message))
            except ValueError:
                return flask.abort(403)
            except:
                return flask.abort(500)
            return "success!\n"

        if flask.request.method == "DELETE":
            # curl -X DELETE -w 'exit status: %{http_code}' http://localhost:9876
            message = {
                "encoding": "markdown",
                "content": "smdv closed by user through a DELETE request.",
            }
            eventloop.run_until_complete(put(message))
            try:
                eventloop.run_until_complete(delete())
            finally:
                return stop_flask_server()

        return flask.abort(403)

    return app


def state_event() -> dict:
    return {"type": "STATE", **state}


def client_event() -> dict:
    return {"type": "CLIENT", "num_clients": len(clients)}


def pandoc(content: str, _from: str = "markdown", _to: str = "html"):
    """convert string content with pandoc

    Args:
        content: the content to convert
        _from: the type of the input content {"markdown", "html", ...}
        _to: the type of the output content {"html", "markdown", ...}

    Returns:
        out: the output content

    """
    # bugfix for pandoc: make % shown as a single % (in stead of stopping conversion)
    content = content.replace("%", "%%")
    cmd = ["pandoc", "--from", _from, "--to", _to, "-"]
    piped = subprocess.Popen(["printf", content], stdout=subprocess.PIPE).stdout
    out = subprocess.check_output(cmd, stdin=piped).decode().strip()
    return out


def notify_send(title, content=""):
    """send a notification using notify-send

    Args:
        title: title of the notification
        content: content of the notification
    """
    cmd = ["notify-send", title]
    if content:
        cmd.append(content)
    subprocess.check_call(cmd)


def filter_urls(message: dict):
    html = message["content"]
    urls = (
        re.findall('src="(.*?)"', html)
        + re.findall("src='(.*?)'", html)
        + re.findall('href="(.*?)"', html)
        + re.findall("href='(.*?)'", html)
    )
    cwd = pathlib.Path(message["cwd"])
    for url in urls:
        if not url.startswith("http://") and not url.startswith("https://"):
            path = re.sub("//", "/", str((cwd / url).expanduser().absolute()))
            html = html.replace(f'"{url}"', f'"http://{host}:{port}{path}?root=1"')
    message["content"] = html
    return message


def md2html(message: dict) -> dict:
    message["content"] = pandoc(
        message["content"],
        _from="markdown",
        _to="html",  # gfm: github flavored markdown
    )
    message["encoding"] = "html"
    message = filter_urls(message)
    return message


def ipynb2html(message: dict) -> dict:
    """convert jupyter notebook

    TODO: make this work from stdin

    Args:
        content: the notebook contents to convert

    Returns:
        html: str: the html representation for the requested jupyter notebook file.

    Note:
        this function requires nbconvert

    """
    from nbconvert.nbconvertapp import NbConvertApp
    from nbconvert.exporters.html import HTMLExporter

    # create an NbConvertApp:
    app = NbConvertApp.instance()
    # initialize the app with the arguments
    app.initialize(["--template=basic"])
    # create an exporter
    app.exporter = HTMLExporter(config=app.config)
    # get html output
    message["content"], _ = app.export_single_notebook(
        notebook_filename=None,
        resources=None,
        input_buffer=io.StringIO(message["content"]),
    )
    message["encoding"] = "html"
    message = filter_urls(message)
    return message


def dir2html(message: dict):
    cwd = pathlib.Path(message["cwd"])
    listcontent = os.listdir(cwd)
    directories = sorted(
        [d for d in listcontent if os.path.isdir(cwd / d)], key=lambda d: d.lower()
    )
    files = sorted(
        [f for f in listcontent if not os.path.isdir(cwd / f)], key=lambda f: f.lower()
    )
    if cwd != pathlib.Path("/"):
        message["content"] = f'🔼 <a href="..">up</a><br>\n'
    else:
        message["content"] = ""
    for filename in directories:
        message["content"] += f'📂 <a href="{filename}">{filename}</a><br>\n'
    for filename in files:
        message["content"] += f'📄 <a href="{filename}">{filename}</a><br>\n'
    message = filter_urls(message)
    return message


async def send_state():
    if clients:
        message = json.dumps(state_event())
        await asyncio.wait([client.send(message) for client in clients])


async def notify_clients():
    if clients:
        message = json.dumps(client_event())
        await asyncio.wait([client.send(message) for client in clients])


async def register_client(client):
    clients.add(client)
    await notify_clients()


async def unregister_client(client):
    clients.remove(client)
    await notify_clients()


async def put(message):
    """ send message from flask to websocket server after PUT request """
    global last_file_message

    if not isinstance(message, dict):
        try:
            message = json.loads(message)
        except ValueError:
            message = {
                "content": message,
            }
    putflag = message.get("put", False)  # put=1 flag in request arguments
    content = message.get("content", "")
    encoding = message.get("encoding", "")
    path = pathlib.Path(message.get("path", "")).absolute()
    if "filename" in message and not "path" in message:
        if not "cwd" in message:
            path = pathlib.Path(message["filename"]).absolute()
        else:
            path = pathlib.Path(message["cwd"]).absolute() / message["filename"]
    if path.is_dir():
        filename = ""
        cwd = str(path)
        if not content:
            encoding = "directory"
        elif not encoding:
            encoding = "markdown"
    else:
        filename = f"{path.stem}{path.suffix}"
        cwd = str(path.parents[0])
        with open(path, "r") as file:
            content = file.read()
        if path.suffix == ".ipynb":
            encoding = "jupyter"
        else:
            if path.suffix != ".md" and encoding != "markdown":
                content = f"```\n{content}\n```"
            encoding = "markdown"

    message = {
        "cwd": re.sub("^/+", "/", cwd),
        "filename": filename,
        "content": content,
        "encoding": encoding,
    }
    if encoding == "directory" and putflag and last_file_message:
        message = last_file_message
    elif encoding == "directory":
        message = dir2html(message)
    elif encoding == "markdown":
        message = last_file_message = md2html(message)
    elif encoding == "jupyter":
        message = last_file_message = ipynb2html(message)
    else:
        raise ValueError(f"invalid encoding '{encoding}'")

    uri = f"ws://{ws_host}:{ws_port}"
    message = {"type": "PUT", **message}
    async with websockets.connect(uri) as client:
        await client.send(json.dumps(message))


async def ask_num_clients():
    """ send message from flask to websocket server after PUT request """
    uri = f"ws://{ws_host}:{ws_port}"
    async with websockets.connect(uri) as client:
        await client.send(json.dumps({"type": "NUMCLIENTS"}))
        message = await client.recv()
    message = json.loads(message)
    if message["type"] == "CLIENT":
        return int(message["num_clients"])
    raise RuntimeError("could not get number of connected clients")


async def delete():
    """ send message from flask to websocket server after DELETE request """
    uri = f"ws://{ws_host}:{ws_port}"
    async with websockets.connect(uri) as client:
        await client.send(json.dumps({"type": "DELETE"}))


async def connect_to_client(client, path):
    await register_client(client)
    await client.send(json.dumps(state_event()))
    try:
        async for message in client:
            message = json.loads(message)
            type = message.pop("type")
            if type == "PUT":
                state.update(message)
            elif type == "DELETE":
                with nostdout():
                    exit()
            elif type == "EDIT":
                path = pathlib.Path(message["cwd"]).absolute() / message["filename"]
                edit_in_neovim(path)
            elif type == "NUMCLIENTS":
                await notify_clients()
    finally:
        await unregister_client(client)
        await send_state()


def stop_flask_server():
    shutdown = flask.request.environ.get("werkzeug.server.shutdown")
    try:
        shutdown()
    except:
        return flask.abort(500)
    return "succes!\n"


def render_template(**kwargs):
    with open(here / "smdv.js", "r") as file:
        js = file.read()
    with open(html_template, "r") as file:
        jinja2_html = file.read()
    jinja2_html = jinja2_html.replace("<head>", f"<head>\n{html_meta}\n")
    jinja2_html = jinja2_html.replace(
        "</head>", f"\n<script>\n{js}\n</script>\n</head>"
    )
    jinja2_html = jinja2_html.replace("<body>", f"<body>\n{navbar}\n")
    template = jinja2.Environment(
        loader=jinja2.FileSystemLoader(html_template.parents[0])
    ).from_string(jinja2_html)
    html = template.render(
        host=host,
        port=port,
        ws_host=ws_host,
        ws_port=ws_port,
        home=str(home),
        **kwargs,
    )
    return html


def is_binary_file(path: pathlib.Path) -> bool:
    """check if a file can be considered a binary file

    Args:
        path: the absolute path of the file to check

    Returns:
        is_binary_string: whether it's a binary file or not.
    """
    textchars = (
        bytearray([7, 8, 9, 10, 12, 13, 27])
        + bytearray(range(0x20, 0x7F))
        + bytearray(range(0x80, 0x100))
    )
    is_binary_string = lambda bytes: bool(bytes.translate(None, textchars))

    if not path.exists():
        return False

    if is_binary_string(open(path, "rb").read(1024)):
        return True
    else:
        return path.suffix in (".svg",)


def socket_in_use(address: str) -> bool:
    """check if a socket is in use

    Args:
        address: str: the address of the unix/inet socket

    Returns:
        in_use: bool: wether the socket is in use or not.
    """

    if ":" in address:  # inet socket
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        host, port = address.split(":")
        result = sock.connect_ex((host, int(port)))
        if result == 0:
            return True
        else:
            return False
        sock.close()
    else:  # unix socket
        if os.path.exists(address):
            return True
        return False


def edit_in_neovim(path: pathlib.Path):
    """ open file in neovim (requires neovim remote) """
    path = str(path.absolute())
    if not os.path.exists(path):
        return
    if not ":" in nvim_address:  # unix socket
        os.makedirs(os.path.dirname(nvim_address), exist_ok=True)
    if socket_in_use(nvim_address):
        cmd = ["nvr", "-s", "--nostart", "--servername", nvim_address, path]
    else:
        # terminal = os.environ.get("TERMINAL")
        # cmd = [terminal, "-e", "nvr", "-s", "--servername", nvim_address, path]
        return
    subprocess.Popen(cmd)


def run_websocket_server():
    # the websocket server should use a different event loop than the global flask
    # websocket client event loop
    with nostdout():
        eventloop = asyncio.new_event_loop()
        asyncio.set_event_loop(eventloop)
        websocket_server = websockets.serve(connect_to_client, ws_host, ws_port)
        eventloop.run_until_complete(websocket_server)
        eventloop.run_forever()


def run_flask_server():
    with nostdout():
        create_app().run(host=host, port=port, debug=False, threaded=True)


def open_browser():
    """spawn a new browser to open smdv"""
    url = f"http://{host}:{port}"
    if browser == "chromium --app":
        subprocess.Popen(["chromium", f"--app={url}"])
    elif browser:
        subprocess.Popen([browser, url])
    elif subprocess.call(["which", "xdg-open"]) == 0:
        subprocess.Popen(["xdg-open", url])
    else:
        webbrowser.open(url)


def main():

    SMDV_DEFAULT_ARGS = os.environ.get("SMDV_DEFAULT_ARGS", "")
    if SMDV_DEFAULT_ARGS:
        globals().update(parse_args(SMDV_DEFAULT_ARGS.split(" ")))
    globals().update(parse_args(sys.argv[1:]))

    print(f"\n")
    print(f"smdv @ http://{host}:{port}")
    print(f"\n")
    print(
        f"please note that browser navigation (back, forward, ...) for smdv works best with Firefox."
    )
    print(f"\n")

    try:
        flask_thread, ws_thread = None, None
        if not socket_in_use(f"{host}:{port}"):
            flask_thread = threading.Thread(target=run_flask_server)
            flask_thread.start()
        if not socket_in_use(f"{ws_host}:{ws_port}"):
            ws_thread = threading.Thread(target=run_websocket_server)
            ws_thread.start()

        message = {}
        message["path"] = str(pathlib.Path(os.getcwd()).absolute())
        if filename.exists():
            message["path"] = str(filename.absolute())
        if stdin:
            message["content"] = sys.stdin.read()
        eventloop.run_until_complete(put(message))

        num_clients = eventloop.run_until_complete(ask_num_clients())

        if not no_browser:
            if num_clients < 2:
                open_browser()
                if not stdin:
                    notify_send("smdv", f"opening '{filename}' in new browser window")
                else:
                    notify_send(
                        "smdv",
                        "reading from stdin and placing content in new browser window",
                    )
            else:
                if not stdin:
                    notify_send(
                        "smdv", f"opening '{filename}' in already open browser window"
                    )
                else:
                    notify_send(
                        "smdv",
                        "reading from stdin and placing content in already open browser window",
                    )
    except OSError:
        with nostdout():
            exit(1)
    finally:
        if ws_thread is not None and socket_in_use(f"{ws_host}:{ws_port}"):
            ws_thread.join()
        if flask_thread is not None and socket_in_use(f"{host}:{port}"):
            flask_thread.join()


if __name__ == "__main__":
    main()
