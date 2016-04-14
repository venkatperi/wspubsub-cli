var Log, WSPubSub, parser, quit, startServer;

parser = require('nomnom');

WSPubSub = require("node-wspubsub");

Log = require("yandlr")({
  module: module
});

quit = function(err, code) {
  if (err != null) {
    Log.e(err);
  }
  Log.i("Stopping...");
  return process.exit(code || 0);
};

startServer = function(opts) {
  var err, server;
  Log.i("Starting...");
  try {
    server = new WSPubSub(opts);
    server.start();
  } catch (_error) {
    err = _error;
    quit(err, -1);
  }
  return process.on('SIGINT', function() {
    Log.i("Got SIGINT");
    server.stop();
    return setTimeout(quit, 300);
  });
};

parser.script("wspubsub");

parser.command("start").option("host", {
  help: "Websocket server host"
}).option("port", {
  help: "Websocket server port"
}).option("path", {
  help: "Websocket server path"
}).help("Start websocket pubsub server").callback(startServer);

parser.parse();
