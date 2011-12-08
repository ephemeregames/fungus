class Launcher
  constructor: ->
    @_fatal = new Fatal()
    
    #try
    @game = new window.Game()
    @game.start()
    
    #catch error
    #  if (error == "PlatformUnsupported")
    #    @_fatal.setPlatformUnsupported()
    #  else
    #    throw error
        
    #  if (@game?)
    #    @game.stop()
