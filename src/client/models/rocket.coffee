Entity = require('./entity')

class Rocket extends Entity

  @assets = ["resources/images/rocket.png"]
  @count = 0

  constructor: (x, y, @radius, @state, @parent, @target) ->
    super({image: "resources/images/rocket.png", x: x, y: y, anchor: "center"})
    @id = Rocket.count++
    @speed = 3.5
    @alive = true
    @scale(0.5)

  update: ->
    if @alive
      if not @goto(@target.x,@target.y)
        @destroy()

  draw: ->
    if @alive
      super.draw

  destroy: ->
    @alive = false




module.exports = Rocket
