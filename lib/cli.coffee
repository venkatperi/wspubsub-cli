parser = require( 'nomnom' )
WSPubSub = require "node-wspubsub"
conf = require "./conf"

startServer = ( opts ) ->
  server = new WSPubSub opts
  server.start()

parser.script "wspubsub"
parser.command "start"
.option "host",
  help : "Websocket server host"

.option "port",
#  default: conf.get "port"
  help : "Websocket server port"

.option "path",
#  default: conf.get "path"
  help : "Websocket server path"

.help "Start websocket pubsub server"
.callback startServer

parser.parse()

