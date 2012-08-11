class RotatingCube
  constructor: ->
    geometry = new THREE.CubeGeometry(200, 200, 200);
    material = new THREE.MeshBasicMaterial({ color: 0xFF0000, wireframe: true })
    
    @mesh = new THREE.Mesh(geometry, material)


  update: =>
    @mesh.rotation.x += 0.01
    @mesh.rotation.y += 0.02

