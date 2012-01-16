Planet = require '../models/planet'
Ship = require '../models/ship'


class PlayState

  setup: ->

    @planets = new jaws.SpriteList()
    @ships = new jaws.SpriteList()

    for num in [1..10]
      r = 20 + (Planet.MAX_RADIUS - 20) * Math.random()
      x = Math.floor(Math.random() * (game.width))
      y = Math.floor(Math.random() * (game.height))
      @planets.push( new Planet(x,y,r,this))

    for num in [1..15]
      r = 5 + (Ship.MAX_RADIUS - 5) * Math.random()
      x = (7*game.width/8) + Math.floor(Math.random() * (game.width/8))
      y = Math.floor(Math.random() * (game.height))
      @ships.push( new Ship(x,y,r,this,0))

    for num in [1..15]
      r = 5 + (Ship.MAX_RADIUS - 5) * Math.random()
      x = Math.floor(Math.random() * (game.width/8))
      y = Math.floor(Math.random() * (game.height))
      @ships.push( new Ship(x,y,r,this,1))


    @viewport = new jaws.Viewport({max_x: 50000, max_y: 50000})

    @parallax = new jaws.Parallax({repeat_x: true, repeat_y: true})
    @parallax.addLayer({image: "resources/images/space.png", damping: 10})
    @parallax.addLayer({image: "resources/images/space2.png", damping: 60})


    console.log "Beginning game loop..."

  update: ->
    @planets.update()
    @ships.update()
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
    ships = @ships
    @parallax.draw()
    @viewport.apply( ->
      planets.draw()
      ships.draw()
    )


module.exports = PlayState
