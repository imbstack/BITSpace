{puts} = require 'util'
fs   = require 'fs'
url  = require 'url'
path = require 'path'

connect = require 'connect'

class Application

  constructor: (@server, @config) ->



createAppServer = (config) ->
  webroot = path.join path.dirname(fs.realpathSync(__filename)), '../../'

  server = connect.createServer()
  server.use '/', connect.static(webroot)
  server.app = new Application(server, config)

  return server


module.exports = createAppServer
