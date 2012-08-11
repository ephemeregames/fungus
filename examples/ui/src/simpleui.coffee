class SimpleUI
  constructor: ->
    @dialog =
      jQuery('<div></div>').
        html("Je propose qu'on utilise jQueryUI comme librairie de UI.").
        dialog({ 'autoOpen': false, 'title': 'Oh yeah!' })

    @dialog.dialog('open')

