class Assets
  constructor: (@descriptor) ->
    @packages = {}

    for p in @descriptor.packages
      @packages[p] = new AssetPackage(p)


  isAllPackagesDownloaded: =>
    for name, aPackage of @packages
      return false if !aPackage.isDownloadCompleted

    return true


  start: (callback) =>
    if (@descriptor.downloadAll)
      @_allPackagesDownloadedCallback = callback

      for name, aPackage of @packages
        this.download(name, this._packageDownloadedCallback)

    else if (@packages['core']?)
      this.download('core', callback)


  download: (packageName, callback) =>
    @packages[packageName].download("#{@descriptor.folder}/", callback)


  getAsset: (name) =>
    #todo: cache assets in {}
    for pname, aPackage of @packages
      return aPackage.getAsset(name) if aPackage.containsAsset(name)

    return null


  _packageDownloadedCallback: =>
    if (this.isAllPackagesDownloaded() and @_allPackagesDownloadedCallback?)
      @_allPackagesDownloadedCallback()
      delete @_allPackagesDownloadedCallback

