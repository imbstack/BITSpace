PlayState = require('./states/play')

Planet = require './models/planet'
Ship = require './models/ship'



class Game
  constructor: ->
    @width = $(window).width()
    @height = $(window).height()
    console.log "Starting BITSpace..."
    console.log "Viewport size detected as #{@height}x#{@width}"
    @height = Math.floor(0.9 * @height) # give some space at the bottom of screen
    @width = Math.floor(1.7 * @height) #width is now the width of the canvas instead of the viewport
    $("#content").css({"width": @width, "height": @height})


    start = @start

    home = $("#home")
    play = $("#play")
    options = $("#options")

    canvas = $("<canvas id='game' width=#{@width} height=#{@height}></canvas>")
    play.append(canvas)

    home.find(".play").click( ->
      home.hide()
      play.show()
      start()
    )

    home.find(".options").click( ->
      home.hide()
      options.show()
    )

    options.find(".home").click( ->
      options.hide()
      home.show()
    )

  start: ->
    console.log "Loading assets..."
    jaws.assets.add(Planet.assets)
    jaws.assets.add(Ship.assets)
    jaws.assets.add(["resources/images/space.png", "resources/images/space2.png"])

    jaws.preventDefaultKeys(["up", "down", "left", "right", "space"])
    jaws.start(PlayState, {game: this})

module.exports = Game
