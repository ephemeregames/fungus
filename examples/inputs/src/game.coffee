class @Game extends Fungus.Game
  constructor: ->
    super
    
    @scene = @scenes.createScene 'main'
    @scenes.setActive 'main'
    

  draw: =>
    text = new Fungus.Text("keys pressed: #{@inputs.currentInput.keysPressed.join(',')}")
    text.position.x = 100
    text.position.y = 100

    text2 =
      new Fungus.Text(
        "mouse position: #{@inputs.currentInput.mousePosition.x},#{@inputs.currentInput.mousePosition.y}")
    text2.position.x = 100
    text2.position.y = 150
    
    @scene.addToDrawIn2D(text)
    @scene.addToDrawIn2D(text2)    

    super

