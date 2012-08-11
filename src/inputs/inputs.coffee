class Input
  constructor: ->
    # basic
    @keysPressed = new Array()
    @keysReleased = new Array()
    @mousePosition = { 'x': 0, 'y': 0 }
    @mousePositionDelta = { 'x': 0, 'y': 0 }
    @mouseButtonsPressed = new Array()
    @mouseButtonsReleased = new Array()
    #@mouseWheel = Mouse.MiddleNone //todo

    # deducted
    @keysHold = new Array()
    @keysPressedOnce = new Array()
    @mouseButtonsHold = new Array()
    @mouseButtonsPressedOnce = new Array()


  construct: (previous, current) =>
    # basic
    @keysPressed = current.keysPressed.slice(0)
    @keysReleased = current.keysReleased.slice(0)
    @mouseButtonsPressed = current.mouseButtonsPressed.slice(0)
    @mouseButtonsReleased = current.mouseButtonsReleased.slice(0)

    # mouse position
    @mousePosition.x = current.mousePosition.x
    @mousePosition.y = current.mousePosition.y
    @mousePositionDelta.x = current.mousePosition.x - previous.mousePosition.x
    @mousePositionDelta.y = current.mousePosition.y - previous.mousePosition.y

    list = null

    # construct the list of keys that have
    # been hold for more than one tick and
    # the list of [pressed than released]
    for key in previous.keysPressed
      index = jQuery.inArray(key, @keysReleased)
      list = if (index == -1) then @keysHold else @keysPressedOnce
      list.push(key)

    for key in previous.keysHold
      index = jQuery.inArray(key, @keysReleased)
      list = if (index == -1) then @keysHold else @keysPressedOnce
      list.push(key)

    # construct the list of mouse buttons that have
    # been hold for more than one tick and
    # the list of [pressed than released]
    for button in previous.mouseButtonsPressed
      index = jQuery.inArray(button, @mouseButtonsReleased)
      list = if (index == -1) then @mouseButtonsHold else @mouseButtonsPressedOnce
      list.push(button)

    for button in previous.mouseButtonsHold
      index = jQuery.inArray(button, @mouseButtonsReleased)
      list = if (index == -1) then @mouseButtonsHold else @mouseButtonsPressedOnce
      list.push(button)


  clear: =>
    @keysPressed.clear()
    @keysHold.clear()
    @keysReleased.clear()
    @keysPressedOnce.clear()
    @mousePosition = { 'x': 0, 'y': 0 }
    @mousePositionDelta = { 'x': 0, 'y': 0 }
    @mouseButtonsPressed.clear()
    #@mouseWheel = Mouse.MiddleNone //todo
    @mouseButtonsHold.clear()
    @mouseButtonsReleased.clear()
    @mouseButtonsPressedOnce.clear()


  #clone: =>
  #  return jQuery.extend(true, {}, this);


class Inputs
  constructor: (@canvas) ->
    @_previousFrameInput = new Input()
    @_currentFrameInput = new Input()
    @_currentMousePosition = { 'x': 0, 'y': 0 }
    @currentInput = new Input()

    jQuery(document).keydown(this._doKeyDown)
    jQuery(document).keyup(this._doKeyUp)

    jQuery(document).mousedown(this._doMouseDown)
    jQuery(document).mouseup(this._doMouseUp)
    jQuery(document).mousemove(this._doMouseMoved)


  _doKeyDown: (data) =>
    @_currentFrameInput.keysPressed.push(data.keyCode)


  _doKeyUp: (data) =>
    @_currentFrameInput.keysReleased.push(data.keyCode)


  _doMouseDown: (data) =>
    @_currentFrameInput.mouseButtonsPressed.push(data.which)


  _doMouseUp: (data) =>
    @_currentFrameInput.mouseButtonsReleased.push(data.which)


  _doMouseMoved: (data) =>
    @_currentMousePosition.x = data.pageX
    @_currentMousePosition.y = data.pageY


  update: =>
    @currentInput.clear()
    @_currentFrameInput.mousePosition.x = @_currentMousePosition.x
    @_currentFrameInput.mousePosition.y = @_currentMousePosition.y
    @currentInput.construct(@_previousFrameInput, @_currentFrameInput)
    @_previousFrameInput = @_currentFrameInput
    @_currentFrameInput = new Input()

