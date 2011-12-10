class UserData
  constructor: ->
    @_storage = localStorage


  isSupported: =>
    return @_storage?


  saveObject: (key, obj) =>
    return if not this.isSupported()

    try
      @_storage[key] = JSON.stringify(obj)
    catch error
      # maybe the quota is exceeded. todo: handle


  loadObject: (key) =>
    return null if not this.isSupported()

    return JSON.parse(@_storage[key])


  removeObject: (key) =>
    return if not this.isSupported()

    @_storage.removeItem(key)


  reset: =>
    @_storage.clear()

