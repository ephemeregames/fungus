class @Game extends Fungus.Game
  constructor: ->
    super
    
    @scene = @scenes.createScene 'main'
    @scenes.setActive 'main'

    @assets = new Fungus.Assets({
      'folder': 'assets',
      'packages': [{ 'name': 'core', 'data': [
        'troll.jpg',
        'troll2.jpg',
        'troll3.jpg',
        'troll4.jpg',
        'troll5.jpg'
      ] }],
      'downloadAll': true
    })

    @assets.start()


  draw: =>
    text = new Fungus.Text('visual fps: ' + @_timerVisual.fps().toFixed(2).toString())
    text.position.x = 30
    text.position.y = 30
    text.priority = 0
    
    text2 = new Fungus.Text('logic fps: ' + @_timerSimulator.fps().toFixed(2).toString())
    text2.position.x = 30
    text2.position.y = 60
    text2.priority = 0
    
    @scene.addToDrawIn2D(text)
    @scene.addToDrawIn2D(text2)

    if (@assets.isAllPackagesDownloaded())
      img = new Fungus.Image(@assets.getAsset('troll5.jpg'))
      img.priority = 1
      @scene.addToDrawIn2D(img)
        
    
    super

