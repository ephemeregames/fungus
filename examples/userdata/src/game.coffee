class @Game extends Fungus.Game
  constructor: ->
    super
    
    @scene = @scenes.createScene 'main'
    @scenes.setActive 'main'
    
    mysavegame = new Object()
    mysavegame.name = 'Jodi'
    mysavegame.score = 1000

    @datas =  new Fungus.UserData()
    @datas.saveObject('savegame', mysavegame)


  draw: =>
    savegame = @datas.loadObject('savegame')

    text = new Fungus.Text("name: #{savegame.name}, score: #{savegame.score}")
    text.position.x = 100
    text.position.y = 100
    
    @scene.addToDrawIn2D(text)
    
    super

