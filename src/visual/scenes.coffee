class Scenes
  constructor: ->
    @_bufferSize = {
      x: jQuery(window).width(),
      y: jQuery(window).height()
    }
    @_fixedDrawingBuffer = false

    @canvas = new Canvas3D(@_bufferSize)
    @canvas2d = new Canvas2D(@_bufferSize)

    @_data = {}
    @active = null

    jQuery(window).bind 'resize', =>
      this.resize()


  createScene: (name) =>
    scene = new Scene()
    scene.initialize()
    @_data[name] = scene

    return scene


  setActive: (name) =>
    @active = @_data[name]


  setUseFixedDrawingBuffer: (use) =>
    @_fixedDrawingBuffer = use
    this.resize()


  setBufferSize: (size) =>
    @_bufferSize = size
    this.resize()


  draw: =>
    #to do: stateful 2d canvas OR better way to add text to 3d canvas
    @canvas2d.draw(@active.toDrawIn2D)
    @active.toDrawIn2D.clear()

    @canvas.draw(@active, @active.camera)


  resize: =>
    if (!@_fixedDrawingBuffer)
      @_bufferSize.x = jQuery(window).width()
      @_bufferSize.y = jQuery(window).height()

    for name, scene of @_data
      scene.resize()

    @canvas.resize(@_bufferSize)
    @canvas2d.resize(@_bufferSize)

