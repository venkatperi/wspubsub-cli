Conf = require 'node-conf'

opts =
  name : "wspubsub-cli"
  dirs :
    "factory" : "#{__dirname}/.."

conf = Conf( opts )

module.exports = conf


