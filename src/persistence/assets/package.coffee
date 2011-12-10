class Package
  constructor: (@descriptor) ->
    @_dataDownloaded = {}
    @_dataDownloadedCount = 0


  isDownloadCompleted: =>
    return @_dataDownloadedCount == @descriptor.data.length


  progress: =>
    return @_dataDownloadedCount / @descriptor.data.length


  containsAsset: (name) =>
    return @_dataDownloaded[name]?


  getAsset: (name) =>
    return @_dataDownloaded[name]


  getAssetURL: (folder, name) =>
    return "#{folder}/#{name}"


  download: (folder, @callback) =>
    if (this.isDownloadCompleted())
      @callback() if @callback?
      delete @callback
      return

    for name in @descriptor.data
      this._downloadFile(name, folder + name)


  _downloadFile: (name, path) =>
    if (name.endsWith('.jpg') or name.endsWith('.png'))
      img = new Image()
      img.src = path
      img.onload = =>
        @_dataDownloaded[name] = img
        @_dataDownloadedCount++

        if (this.isDownloadCompleted() and @callback?)
          @callback()
          delete @callback
      img.onerror = =>
        this._downloadFile(name, path)
    else
      $.ajax({
        url: path,
        success: (data) =>
          @_dataDownloaded[name] = data
          @_dataDownloadedCount++
        ,error: => #re-download the file on error
          this._downloadFile(name, path)
        ,complete: =>
          if (this.isDownloadCompleted() and @callback?)
            @callback()
            delete @callback
      })

