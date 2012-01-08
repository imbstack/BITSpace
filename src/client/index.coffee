Planet = require './models/planet'

class World
  constructor: ->

  start: ->
    width = $(window).width()
    height = $(window).height()
    console.log "Starting BITSpace..."
    console.log "Viewport size detected as #{height}x#{width}"
    height = Math.floor(0.9 * height) # give some space at the bottom of screen
    width = Math.floor(1.7 * height) #width is now the width of the canvas instead of the viewport
    $("#content").css({"width": width})

    director = new CAAT.Director().initialize(width,height)
    $("#content").append(director.canvas)
    scene = director.createScene()

    #LOADING ASSETS
    console.log "Loading assets..."

    path = new CAAT.PathActor().
      setBounds(0,0,width,height).
      create().
      setPath(
        new CAAT.Path().
          beginPath(125,225).
          addCubicTo( 125,125,   325,125,   325,225 ).
          addCubicTo( 325,325,  125,325,  125,225 ).
          endPath().
          setInteractive(true))

    planet = new Planet 40,40,20

    circle = planet.repr

    path2 = new CAAT.PathActor().
      setBounds(0,0,width,height).
      create().
      setPath(
        new CAAT.Path().
          beginPath(25,125).
          addCubicTo( 25,25,   225,25,   225,125 ).
          addCubicTo( 225,225,  25,225,  25,125 ).
          endPath().
          setInteractive(true))

    circle2 = new CAAT.ShapeActor().
      setLocation(width/2, height/2).
      setSize(50,50).
      setFillStyle('#ffff00').
      setStrokeStyle('#fff').
      enableEvents(false)

    behavior = new CAAT.PathBehavior().
      setPath(path.getPath()).
      setFrameTime(0,5000).
      setCycle(true).
      setTranslation(circle.width/2, circle.height/2).
      setAutoRotate(true)

    behavior2 = new CAAT.PathBehavior().
      setPath(path2.getPath()).
      setFrameTime(0,5000).
      setCycle(true).
      setTranslation(circle2.width/2, circle2.height/2).
      setAutoRotate(true)

     

    circle.addBehavior(behavior)
    circle2.addBehavior(behavior2)


    CAAT.registerKeyListener (key,action) ->
      if ( key==65 && action=='up') 
        behavior3 = new CAAT.AlphaBehavior().
          setValues(1.0,0.0).
          setFrameTime(director.time,director.time + 1)
        path3 = new CAAT.PathActor().
          setBounds(0,0,width,height).
          setDiscardable(true).
          create()
        path3.setPath(
          new CAAT.Path().
            beginPath(circle2.x + circle2.width/2,circle2.y + circle2.height/2).
            addLineTo( circle.x + circle.width/2,circle.y + circle.height/2, 'rgb(255,255,255)' ).
            endPath().
            setInteractive(false))
        path3.addBehavior(behavior3)
        scene.addChild(path3)

        

    scene.addChild(path)
    scene.addChild(circle)
    scene.addChild(path2)
    scene.addChild(circle2)

    #BEGIN GAME LOOP 
    console.log "Beginning game loop..."
    director.loop(1)
  

module.exports = World
