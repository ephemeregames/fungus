class @Timer
  constructor: (target) ->
    @target = target
    @average = 0
    @callback = null
    @skipFrames = no

    @_currentTime = 0
    @_accumulatedTime = 0


  start: =>
    @_currentTarget = @target
    @_gameLoopTimer = setInterval(this.update, @_currentTarget)
    @_currentTime = (new Date).getTime()


  update: =>
    # restart the internal timer if the target FPS changes
    if (@target != @_currentTarget)
      stop()
      start()
      return

    newTime = (new Date).getTime()
    deltaTime = newTime - @_currentTime
    @average = @average * 0.9 + deltaTime * 0.1 # update average
    @_currentTime = newTime

    @_accumulatedTime += deltaTime

    return if (@_accumulatedTime < @target)

    # if we skip frames
    if (@skipFrames)
      if (@_accumulatedTime >= @target)
        @callback()
        @_accumulatedTime = 0

      return


    while (@_accumulatedTime >= @target)
      @callback()
      @_accumulatedTime -= @target;


  stop: =>
    clearInterval(@_gameLoopTimer)


  fps: =>
    (@target / @average) * @target
