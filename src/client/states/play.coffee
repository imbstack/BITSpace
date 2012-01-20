Planet = require '../models/planet'
Ship = require '../models/ship'
Rocket = require '../models/rocket'


class PlayState

  setup: ->

    @planets = new jaws.SpriteList()
    @team0 = new jaws.SpriteList()
    @team1 = new jaws.SpriteList()
    @rockets = new jaws.SpriteList()
    @splosions = new jaws.SpriteList()

    for num in [1..3]
      r = 20 + (Planet.MAX_RADIUS - 20) * Math.random()
      x = Math.floor(Math.random() * (game.width))
      y = Math.floor(Math.random() * (game.height))
      @planets.push( new Planet(x,y,r,this))

    for num in [1..15]
      r = 5 + (Ship.MAX_RADIUS - 5) * Math.random()
      x = (7*game.width/8) + Math.floor(Math.random() * (game.width/8))
      y = Math.floor(Math.random() * (game.height))
      @team0.push( new Ship(x,y,r,this,0))

    for num in [1..15]
      r = 5 + (Ship.MAX_RADIUS - 5) * Math.random()
      x = Math.floor(Math.random() * (game.width/8))
      y = Math.floor(Math.random() * (game.height))
      @team1.push( new Ship(x,y,r,this,1))


    @viewport = new jaws.Viewport({max_x: 5000, max_y: 5000})

    @parallax = new jaws.Parallax({repeat_x: true, repeat_y: true})
    @parallax.addLayer({image: "resources/images/space.png", damping: 10})
    @parallax.addLayer({image: "resources/images/space2.png", damping: 60})


    console.log "Beginning game loop..."

  update: ->
    @planets.update()
    @team0.update()
    @team1.update()
    @rockets.update()
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
    team0 = @team0
    team1 = @team1
    rockets = @rockets
    splosions = @splosions
    @parallax.draw()
    @viewport.apply( ->
      planets.draw()
      team0.draw()
      team1.draw()
      rockets.draw()
      splosions.draw()
    )


module.exports = PlayState
