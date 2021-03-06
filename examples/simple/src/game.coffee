class @Game extends Fungus.Game
  constructor: ->
    super
    
    @scene = @scenes.createScene 'main'
    @scenes.setActive 'main'
    
    @cube = new RotatingCube()
    
    @scene.add @cube.mesh


  update: =>
    @cube.update()
    
    super


  draw: =>
    text = new Fungus.Text('visual fps: ' + @_timerVisual.fps().toString())
    text.position.x = 30
    text.position.y = 30
    
    text2 = new Fungus.Text('logic fps: ' + @_timerSimulator.fps().toString())
    text2.position.x = 30
    text2.position.y = 60
    
    @scene.addToDrawIn2D(text)
    @scene.addToDrawIn2D(text2)
    
    super

