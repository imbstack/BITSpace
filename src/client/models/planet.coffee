class Planet extends jaws.Sprite
  
  @MAX_RADIUS = 50
  @PLANET_COUNT = 0
  @assets = ["resources/images/planet.png"]

  constructor: (x, y, @radius, @state) ->
    @id = Planet.PLANET_COUNT++
    super({image: "resources/images/planet.png", x: x, y: y, anchor: "center"})
    @scaleTo(@radius/Planet.MAX_RADIUS)
    scatterX = if Math.random() > 0.5 then 1 else -1
    scatterY = if Math.random() > 0.5 then 1 else -1
    while jaws.collideOneWithMany(this, @state.planets).length != 0
      @move(10 * scatterX, 10 * scatterY)

  update: ->


module.exports = Planet
