coffeekup = window.CoffeeKup

class @Game extends Fungus.Game
  constructor: ->
    super

    @_timerVisual.target = 60
    
    @scene = @scenes.createScene 'main'
    @scenes.setActive 'main'
    
    @cube = new RotatingCube()
    
    @scene.add @cube.mesh

    #@ui = new SimpleUI()
    @debugger = new Debugger(this)


  update: =>
    @cube.update()
    @debugger.update()
    
    super


  draw: =>
    text = new Fungus.Text("visual fps: #{(@_timerVisual.percentage() * 100) | 0}")
    text.position.x = 30
    text.position.y = 30
    
    #text2 = new Fungus.Text('logic fps: ' + @_timerSimulator.fps().toString())
    #text2.position.x = 30
    #text2.position.y = 60
    
    @scene.addToDrawIn2D(text)
    #@scene.addToDrawIn2D(text2)
    
    super

