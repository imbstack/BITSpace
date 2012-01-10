InitState = require('./states/init')

Planet = require './models/planet'
Ship = require './models/ship'


class Game
  constructor: ->
    @initCanvas()

  start: ->
    console.log "Loading assets..."
    jaws.assets.add(Planet.assets)
    jaws.assets.add(Ship.assets)
    jaws.assets.add(["resources/images/space.png", "resources/images/space2.png"])

    jaws.preventDefaultKeys(["up", "down", "left", "right", "space"])
    jaws.start(InitState, {game: this})

  initCanvas: ->
    @width = $(window).width()
    @height = $(window).height()
    console.log "Starting BITSpace..."
    console.log "Viewport size detected as #{@height}x#{@width}"
    @height = Math.floor(0.9 * @height) # give some space at the bottom of screen
    @width = Math.floor(1.7 * @height) #width is now the width of the canvas instead of the viewport
    $("#content").css({"width": @width})

    $("#content").append("<canvas id='game' width=#{@width} height=#{@height}></canvas>")
    @canvas = document.getElementById('game')


module.exports = Game
