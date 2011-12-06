class Game
  constructor: ->
    @scenes = new Scenes()

    @_timerVisual = new Timer(60)
    @_timerVisual.skipFrames = yes
    @_timerVisual.callback = this.update

    @_timerSimulator = new Timer(60)
    @_timerSimulator.callback = this.draw


  update: =>


  draw: =>
    @scenes.draw()


  start: =>
    @_timerVisual.start()
    @_timerSimulator.start()


  stop: =>
    @_timerVisual.stop()
    @_timerSimulator.stop()


  setTargetFPS: (fps) =>
    @_timerVisual.target = fps
    @_timerSimulator.target = fps


  @random: new Random()

