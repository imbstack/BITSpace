class Rocket extends jaws.Sprite

  @assets = ["resources/images/rocket.png"]

  constructor: (x, y, @radius, @state) ->
    super({image: "resources/images/rocket.png", x: x, y: y, anchor: "center"})
    @scale(0.5)

  update: ->
    @goto(@state.team1[0].x,@state.team1[0].y)

  #TODO: Take this and make it a member of some super class
  goto: (x,y) ->
    dx = x - @x
    dy = y - @y
    theta = Math.atan2(dx,-dy)
    @rotateTo(theta * 180/Math.PI)
    @move(dx/150,dy/150)


module.exports = Rocket
