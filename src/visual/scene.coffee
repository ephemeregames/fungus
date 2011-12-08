class Scene extends THREE.Scene
  initialize: =>
    @camera = new THREE.PerspectiveCamera(75, $(window).width() / $(window).height(), 1, 10000)
    @camera.position.z = 500

    this.add(@camera)

    @toDrawIn2D = new Array


  addToDrawIn2D: (drawable) =>
    @toDrawIn2D.push drawable


  resize: =>
    @camera.aspect = $(window).width() / $(window).height()
    @camera.updateProjectionMatrix()

