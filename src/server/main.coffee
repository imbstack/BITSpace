{puts} = require 'util'
fs     = require 'fs'
path   = require 'path'
program = require 'commander'
createAppServer = require './app'


package = JSON.parse( fs.readFileSync('package.json','utf8') )

program
  .version( package.version )
  .option('-c --config <config>', 'Specify a configuration file for the server [config.json]')
  .parse(process.argv)

exports.run = ->
    
  #TODO: Finish building in config file reading and generation (issue #1)
  
  if program.config
    config = JSON.parse( fs.readFileSync(program.config, 'utf8') )
  else
    config = {}
  
  server = createAppServer config
  server.listen config.web.port

  puts "Server listening on port #{config.web.port}"

  return
