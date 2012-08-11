class @Fatal
  constructor: () ->
    jQuery('window').bind 'resize', =>
      this.resize()

  setPlatformUnsupported: =>
    jQuery('body').append('<div id="fungusError">Platform unsupported.</div>')
    jQuery('fungusError').center()

  resize: =>
    element = jQuery('fungusError')

    return if !element?

    element.center()
