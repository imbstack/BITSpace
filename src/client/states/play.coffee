Planet = require '../models/planet'
Ship = require '../models/ship'


class PlayState

  setup: ->

    @planets = new jaws.SpriteList()

    for num in [0..3]
      r = 20 + 40 * Math.random()
      x = Math.floor(Math.random() * (game.width))
      y = Math.floor(Math.random() * (game.height))
      @planets.push( new Planet x,y,r )

    @viewport = new jaws.Viewport({max_x: 50000, max_y: 50000})

    @parallax = new jaws.Parallax({repeat_x: true, repeat_y: true})
    @parallax.addLayer({image: "resources/images/space.png", damping: 10})
    @parallax.addLayer({image: "resources/images/space2.png", damping: 60})


    console.log "Beginning game loop..."

  update: ->
    @planets.update()
    @parallax.camera_x = @viewport.x
    @parallax.camera_y = @viewport.y

    if jaws.pressed('down')
      @viewport.y += 10
    if jaws.pressed('up')
      @viewport.y -= 10
    if jaws.pressed('left')
      @viewport.x -= 10
    if jaws.pressed('right')
      @viewport.x += 10


    
  draw: ->
    planets = @planets
    @parallax.draw()
    @viewport.apply( ->
      planets.draw()
    )


module.exports = PlayState
