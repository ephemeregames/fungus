class Scenes
  constructor: ->
    @canvas = new Canvas3D($(window))
    @canvas2d = new Canvas2D($(window))

    @_data = {}
    @active = null

    $(window).bind 'resize', =>
      this.resize()

    this.resize()


  createScene: (name) =>
    scene = new Scene()
    scene.initialize(@canvas.size)
    @_data[name] = scene

    return scene


  setActive: (name) =>
    @active = @_data[name]


  draw: =>
    #to do: stateful 2d canvas OR better way to add text to 3d canvas
    @canvas2d.draw(@active.toDrawIn2D)
    @active.toDrawIn2D.clear()

    @canvas.draw(@active, @active.camera)


  resize: =>
    width = window.innerWidth
    height = window.innerHeight

    for name, scene of @_data
      scene.setSize({
        x: window.innerWidth,
        y: window.innerHeight
      })

    @canvas.resize()
    @canvas2d.resize()

