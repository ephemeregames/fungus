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

    jQuery('body').append(@renderer.domElement)
    this.fullscreen()


  draw: (scene, camera) =>
    @renderer.render(scene, camera)


  resize: (size) =>
    @size = size
    @renderer.setSize(@size.x, @size.y)
    this.fullscreen()


  fullscreen: =>
    e = jQuery(@renderer.domElement)
    w = jQuery(window)
    
    # there is a difference between element.width and element.css.width...
    e.css('width', w.width())
    e.css('height', w.height())

