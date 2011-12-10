class Assets
  constructor: (@descriptor) ->
    @packages = {}

    for p in @descriptor.packages
      @packages[p] = new Package(p)


  isAllPackagesDownloaded: =>
    for name, package of @packages
      return false if !package.isDownloadCompleted

    return true


  start: (callback) =>
    if (@descriptor.downloadAll)
      @_allPackagesDownloadedCallback = callback

      for name, package of @packages
        this.download(name, this._packageDownloadedCallback)

    else if (@packages['core']?)
      this.download('core', callback)


  download: (packageName, callback) =>
    @packages[packageName].download("#{@descriptor.folder}/", callback)


  getAsset: (name) =>
    #todo: cache assets in {}
    for pname, package of @packages
      return package.getAsset(name) if package.containsAsset(name)

    return null


  _packageDownloadedCallback: =>
    if (this.isAllPackagesDownloaded() and @_allPackagesDownloadedCallback?)
      @_allPackagesDownloadedCallback()
      delete @_allPackagesDownloadedCallback

