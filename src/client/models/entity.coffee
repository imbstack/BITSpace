class Entity extends jaws.Sprite

  goto: (x,y) ->
    dx = x - @x
    dy = y - @y
    if Math.abs(dx) < 1 or Math.abs(dy) < 1
      return false
    theta = Math.atan2(dx,-dy)
    vel_x = -Math.cos(theta)
    vel_y = Math.sin(theta)
    @rotateTo(theta * 180/Math.PI)
    @move(vel_y * @speed, vel_x * @speed)


module.exports = Entity
