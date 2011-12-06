class @Game extends Fungus
  constructor: ->
    @scene = @scenes.createScene 'main'
    @scenes.setActive 'main'

    @cube = new RotatingCube()

    @scene.add @cube.mesh


  update: =>
    @cube.update()
    super


  draw: =>
    text = new Text('visual fps: ' + @_timerVisual.fps().toString())
    text.position = [30, 30]

    text2 = new Text('logic fps: ' + @_timerSimulator.fps().toString())
    text2.position = [30, 60]

    @canvas2d.addToDraw(text)
    @canvas2d.addToDraw(text2)
    super

