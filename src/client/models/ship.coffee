Entity = require('./entity')
Rocket = require './rocket'

class Ship extends Entity

  @assets = ["resources/images/ship.png", "resources/images/splode.png"]
  @MAX_RADIUS = 10
  @count = 0
  @laser = 0
  @TEAM_COLORS = ['rgba(255,0,0,0.5)','rgba(0,255,0,0.5)']
  @LASER_COLORS = ["rgba(255,155,155,", "rgba(155,255,155,"]
  
  constructor: (x, y, @radius, @state, @team) ->
    @speed = 1
    @alive = true
    @active = true
    @id = Ship.count++
    @color = Ship.TEAM_COLORS[team]
    @laser_color = Ship.LASER_COLORS[team]
    super({image: "resources/images/ship.png", x: x, y: y, anchor: "center"})

    @splode = new jaws.Animation({sprite_sheet: "resources/images/splode.png", frame_size: [64,64], frame_duration: 35, loop: false})

    @splode.on_end = => (@destroy)()

    @ctx = jaws.context
    @scaleTo(@radius/Ship.MAX_RADIUS)
    scatterX = if Math.random() > 0.5 then 1 else -1
    scatterY = if Math.random() > 0.5 then 1 else -1
    while jaws.collideOneWithMany(this, @state.planets).length != 0
      @move(10 * scatterX, 10 * scatterY)

  update: ->
    if @alive
      if 0.890 < Math.random() < 0.995 and @active
        @attack('rocket')
      else if 0.995 < Math.random() and @active
        @attack('laser')
      @goto(650,250)
      collisions = jaws.collideOneWithMany(this, @state.rockets)
      done = false
      for c in collisions
        if c.parent.id != @id and c.parent.team != @team
          done = true
          c.destroy()
          break
      if done or jaws.collideOneWithMany(this, @state.planets).length != 0
        @speed = 0
        @active = false
        @setImage(@splode.next())
        @countdown = 50
      if not @active and @countdown-- < 0
        @destroy()


  draw: ->
    if @alive
      @ctx.fillStyle = @color
      @ctx.beginPath()
      @ctx.rect(@x - 30, @y - 30, 10, 10)
      @ctx.closePath()
      @ctx.fill()
      if @laser > 0
        @ctx.strokeStyle = @laser_color + "#{@laser * 0.02})"
        @ctx.fillStyle = @laser_color + "#{@laser * 0.01})"
        @ctx.beginPath()
        @ctx.moveTo(@x,@y)
        @ctx.lineTo(@target.x, @target.y)
        @ctx.stroke()
        @ctx.arc(@target.x,@target.y,5,0,Math.PI*2,false)
        @ctx.fill()
        @laser--
      super.draw

  attack: (type) ->
    if @team == 0
      @target = @state.team1[Math.floor(Math.random() * @state.team1.length)]
    else
      @target = @state.team0[Math.floor(Math.random() * @state.team0.length)]
    if @target.alive
      if type == 'rocket'
        parent = this
        @state.rockets.push( new Rocket(@x, @y, 5, @state, parent, @target) )
      else if type == 'laser'
        @laser = 40
  destroy: ->
    console.log "Ship #{@id} (team #{@team}) destroyed!"
    @alive = false


module.exports = Ship
