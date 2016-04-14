parser = require( 'nomnom' )
WSPubSub = require "node-wspubsub"
Log = require( "yandlr" )( module: module )

quit = ( err, code ) ->
  Log.e err if err?
  Log.i "Stopping..."
  process.exit code or 0

startServer = ( opts ) ->
  Log.i "Starting..."
  try
    server = new WSPubSub opts
    server.start()
  catch err
    quit err, -1

  process.on 'SIGINT', ->
    Log.i "Got SIGINT"
    server.stop()
    setTimeout quit, 300


parser.script "wspubsub"
parser.command "start"
.option "host",
  help : "Websocket server host"

.option "port",
  help : "Websocket server port"

.option "path",
  help : "Websocket server path"

.help "Start websocket pubsub server"
.callback startServer

parser.parse()

