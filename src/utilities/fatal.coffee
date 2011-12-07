class @Fatal
  constructor: () ->
    $('window').bind 'resize', =>
      this.resize()

  setPlatformUnsupported: =>
    $('body').append('<div id="fungusError">Platform unsupported.</div>')
    $('fungusError').center()

  resize: =>
    element = $('fungusError')

    return if !element?

    element.center()
