fs         = require 'fs'
{exec}     = require 'child_process'
browserify = require 'browserify'


task 'build:bundle', 'Compile client js', ->
  b = browserify()
  b.require './src/client', root: __dirname
  fs.writeFileSync 'js/bitspace.js', b.bundle()

task 'build', 'Get assets and js ready', ->
  invoke 'build:bundle'
