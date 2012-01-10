class Planet extends jaws.Sprite

  @assets = ["resources/images/planet.png"]

  constructor: (x, y, @radius) ->
    super({image: "resources/images/planet.png", x: x, y: y, anchor: "center"})

  update: ->
    @move(0.5,0.5)


module.exports = Planet
