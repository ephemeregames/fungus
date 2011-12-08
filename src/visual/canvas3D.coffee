class Canvas3D
  constructor: (@size) ->
    try
      @renderer = new THREE.WebGLRenderer()
    catch error
      try
        @renderer = new THREE.CanvasRenderer()
      catch error
        throw "PlatformUnsupported"

    @renderer.setSize(@size.x, @size.y)
    @renderer.setClearColor('#000000', 1)

    $('body').append(@renderer.domElement)
    this.fullscreen()


  draw: (scene, camera) =>
    @renderer.render(scene, camera)


  resize: (size) =>
    @size = size
    @renderer.setSize(@size.x, @size.y)
    this.fullscreen()


  fullscreen: =>
    e = $(@renderer.domElement)
    w = $(window)
    
    e.css('width', w.width())
    e.css('height', w.height())

