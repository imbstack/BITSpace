PlayState = require('./play')

class InitState
  setup: ->
    @playButton = new jaws.Rect(game.width/2 - 53, game.height/2 + 30, 100,40)

    playButton = @playButton

    $("#game").click((e) ->
      if playButton.collidePoint(e.offsetX,e.offsetY)
        console.log "GAME TIME!"
        jaws.switchGameState(PlayState, {game: game})
      e.preventDefault()
    )

  update: ->
  draw: ->
    jaws.context.fillStyle = "#000"
    jaws.context.fillRect(0,0,game.width,game.height)
    jaws.context.font = "20pt 'Open Sans',Geneva,Arial"
    jaws.context.strokeStyle = "rgb(0,0,0)"
    jaws.context.fillStyle = "rgb(255,255,255)"
    jaws.context.fillText("BITSpace", game.width/2 - 50, game.height/2 - 20)
    jaws.context.fillText("Learn AI the Fun Way", game.width/2 - 50, game.height/2+20)
    jaws.context.fillStyle = "#00f"
    jaws.context.fillText("-> PLAY", game.width/2 - 50, game.height/2 + 60)

module.exports = InitState
