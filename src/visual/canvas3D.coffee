class Canvas3D
  constructor: (@container) ->
    @size = {
      x: @container.width(),
      y: @container.height()
    }

    try
      @renderer = new THREE.WebGLRenderer()
    catch error
      try
        @renderer = new THREE.CanvasRenderer()
      catch error
        throw "PlatformUnsupported"

    @renderer.setSize(@size.x, @size.y)
    @renderer.setClearColor('#000000', 1)

    #tmp
    document.body.appendChild(@renderer.domElement)


  draw: (scene, camera) =>
    @renderer.render(scene, camera)


  resize: =>
    @size.x = @container.width()
    @size.y = @container.height()
    @renderer.setSize(@size.x, @size.y)

