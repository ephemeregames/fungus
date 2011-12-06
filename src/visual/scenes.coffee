class Scenes
  constructor: ->
    @canvas = new Canvas3D($(window))
    @canvas2d = new Canvas2D($(window))

    @_data = {}
    @active = null

    $(window).bind 'resize', =>
      this.resize()


  #initialize: =>
  #  @canvas.initialize()


  createScene: (name) =>
    scene = new Scene()
    scene.initialize(@canvas.size)
    @_data[name] = scene

    return scene


  setActive: (name) =>
    @active = @_data[name]


  draw: =>
    #to do: stateful 2d canvas OR better way to add text to 3d canvas
    @canvas2d.draw()
    @canvas.draw(@active, @active.camera)


  resize: =>
    width = window.innerWidth
    height = window.innerHeight

    for scene in @_data
      scene.setSize({
        x: window.innerWidth,
        y: innerHeight
      })

