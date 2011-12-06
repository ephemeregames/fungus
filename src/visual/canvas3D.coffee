class Canvas3D
  constructor: (@container) ->
    @size = {
      x: @container.width(),
      y: @container.height()
    }

    @renderer = new THREE.WebGLRenderer()
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

