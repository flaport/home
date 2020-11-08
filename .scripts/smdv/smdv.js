// objects
var home = "{{ home }}";
var message = {};
var websocket = new WebSocket("ws://{{ ws_host }}:{{ ws_port }}/");

// functions
var updateURL = function (message) {
  if (message.cwd) {
    let path = message.cwd.replace(home, "~");
    path = path.slice(-1) == "/" ? path : path + "/";
    path = path.slice(0, 1) == "/" ? path : "/" + path;
    if (message.filename) {
      path = path + message.filename;
    } else if (message.encoding != "directory") {
      path = path + "?put=1";
    }
    history.replaceState(message, message.encoding, path);
    if (!message.content) {
      window.location.reload();
    }
  }
};
var updateContent = function (message) {
  if (message.content) {
    document.getElementById("content").innerHTML = message.content;
  }
  if (message.encoding != "directory") {
    document.getElementById("closeFile").innerHTML = "✖";
  } else {
    document.getElementById("closeFile").innerHTML = "";
  }
};
var scrollToMarker = function () {
  var marker = document.getElementById("marker");
  if (marker) {
    marker.scrollIntoView({
      behavior: "smooth",
      block: "center",
      inline: "nearest",
    });
  }
};
var editInNeovim = function (message) {
  if (message.cwd && window.location.href.slice(-5) != "put=1") {
    message = { type: "EDIT", cwd: message.cwd, filename: message.filename };
    console.log(message);
    websocket.send(JSON.stringify(message));
  }
};
var closeFile = function () {
  if (window.location.href.slice(-5) == "put=1") {
    window.location.href = window.location.href.slice(0, -5);
  }
  history.pushState(message, message.encoding, message.cwd);
  window.location.reload();
};

// callbacks
websocket.onmessage = function (event) {
  message = JSON.parse(event.data);
  if (message.type == "STATE") {
    updateContent(message);
    updateURL(message);
    editInNeovim(message);
    scrollToMarker();
  }
};
