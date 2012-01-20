Rocket = require './rocket'

class Ship extends jaws.Sprite

  @assets = ["resources/images/ship.png", "resources/images/splode.png"]
  @MAX_RADIUS = 10
  @SHIP_COUNT = 0
  @TEAM_COLORS = ['rgba(255,0,0,0.5)','rgba(0,255,0,0.5)','rgba(0,0,255,0.5)']
  
  constructor: (x, y, @radius, @state, @team) ->
    @alive = true
    @id = Ship.SHIP_COUNT++
    @color = Ship.TEAM_COLORS[team]
    super({image: "resources/images/ship.png", x: x, y: y, anchor: "center"})

    @splode = new jaws.Animation({sprite_sheet: "resources/images/splode.png", frame_size: [64,64], frame_duration: 30, loop: false})

    @scaleTo(@radius/Ship.MAX_RADIUS)
    scatterX = if Math.random() > 0.5 then 1 else -1
    scatterY = if Math.random() > 0.5 then 1 else -1
    while jaws.collideOneWithMany(this, @state.planets).length != 0
      @move(10 * scatterX, 10 * scatterY)

  update: ->
    if @alive
      if Math.random() > 0.98
        @attack()
      @goto(650,450)
      collisions = jaws.collideOneWithMany(this, @state.team0)
      collisions.concat jaws.collideOneWithMany(this, @state.team1)
      for c in collisions
        @destroy(c)
      if collisions.length != 0
        @destroy(this)
      if jaws.collideOneWithMany(this, @state.planets).length != 0
        @destroy(this)


  draw: ->
    if @alive
      super.draw
      ctx = jaws.context
      ctx.fillStyle = @color
      ctx.beginPath()
      ctx.rect(@x - 30, @y - 30, 10, 10)
      ctx.closePath()
      ctx.fill()

  goto: (x,y) ->
    dx = x - @x
    dy = y - @y
    theta = Math.atan2(dx,-dy)
    @rotateTo(theta * 180/Math.PI)
    @move(dx/350,dy/350)

  attack: ->
    @state.rockets.push( new Rocket(@x, @y, 5, @state) )

  destroy: (c) ->
    console.log "Ship #{c.id} (team #{c.team}) destroyed!"
    c.alive = false
    a = new jaws.Sprite({x: c.x, y: c.y, anchor: "center"})
    a.setImage(@splode.next())
    @state.splosions.push(a)



module.exports = Ship
