class Scene extends THREE.Scene

  initialize: (size) =>
    @camera = new THREE.PerspectiveCamera(75, size.x / size.y, 1, 10000)
    @camera.position.z = 500

    this.add(@camera)

    @toDrawIn2D = new Array


  addToDrawIn2D: (drawable) =>
    @toDrawIn2D.push drawable


  setSize: (size) =>
    @camera.aspect = size.x / size.y
    @camera.updateProjectionMatrix()
