class Scene extends THREE.Scene
  initialize: =>
    @camera = new THREE.PerspectiveCamera(75, jQuery(window).width() / jQuery(window).height(), 1, 10000)
    @camera.position.z = 500

    this.add(@camera)

    @toDrawIn2D = []

    @named_objects = {}


  # We also keep track of objects so we can add named object
  # and later delete them only by giving the name of the object
  add: (object, name = null) =>
    @named_objects[name] = object if name

    super(object)  


  # WARNING An object added by name should be removed by name
  # or memory leak will occur! (the object is removed from the scene but we
  # keep it in our list)
  remove: (name_or_object) =>
    if name_or_object instanceof String
      return unless name_or_object in @named_objects
      object = @named_objects[name_or_object]
      delete @named_objects[name_or_object]
    else
      object = name_or_object

    super(object)


  addToDrawIn2D: (drawable) =>
    @toDrawIn2D.push(drawable)


  resize: =>
    @camera.aspect = jQuery(window).width() / jQuery(window).height()
    @camera.updateProjectionMatrix()

