class Planet

  constructor: (@x, @y, @radius) ->
    @repr = new CAAT.ShapeActor().
      setLocation(@x, @y).
      setSize(500, @radius).
      setFillStyle('#0fffff').
      setStrokeStyle('#fff').
      enableEvents(true)


module.exports = Planet
