class Ship extends jaws.Sprite

  @assets = ["resources/images/ship.png"]
  @MAX_RADIUS = 10
  @SHIP_COUNT = 0
  
  constructor: (x, y, @radius, @state) ->
    @id = Ship.SHIP_COUNT++
    super({image: "resources/images/ship.png", x: x, y: y, anchor: "center"})
    @scaleTo(@radius/Ship.MAX_RADIUS)
    scatterX = if Math.random() > 0.5 then 1 else -1
    scatterY = if Math.random() > 0.5 then 1 else -1
    while jaws.collideOneWithMany(this, @state.planets).length != 0
      @move(10 * scatterX, 10 * scatterY)

  update: ->
    @move(Math.random() - 0.5, Math.random() - 0.5)
    collisions = jaws.collideOneWithMany(this, @state.ships)
    for c in collisions
      c.rotate(1)


module.exports = Ship
