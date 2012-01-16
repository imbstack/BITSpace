class Ship extends jaws.Sprite

  @assets = ["resources/images/ship.png"]
  @MAX_RADIUS = 10
  @SHIP_COUNT = 0
  @TEAM_COLORS = ['rgba(255,0,0,0.5)','rgba(0,255,0,0.5)','rgba(0,0,255,0.5)']
  
  constructor: (x, y, @radius, @state, team) ->
    @id = Ship.SHIP_COUNT++
    @color = Ship.TEAM_COLORS[team]
    super({image: "resources/images/ship.png", x: x, y: y, anchor: "center"})
    @scaleTo(@radius/Ship.MAX_RADIUS)
    scatterX = if Math.random() > 0.5 then 1 else -1
    scatterY = if Math.random() > 0.5 then 1 else -1
    console.log @draw
    while jaws.collideOneWithMany(this, @state.planets).length != 0
      @move(10 * scatterX, 10 * scatterY)

  update: ->
    @move(Math.random() - 0.5, Math.random() - 0.5)
    collisions = jaws.collideOneWithMany(this, @state.ships)
    for c in collisions
      c.rotate(1)


  draw: ->
    ctx = jaws.context
    ctx.fillStyle = @color
    ctx.beginPath()
    ctx.rect(@x - 30, @y - 30, 10, 10)
    ctx.closePath()
    ctx.fill()
    super.draw


module.exports = Ship
