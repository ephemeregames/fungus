class Debugger
  constructor: (@game) ->
    @_template = ->
      div id: 'debugger', title: 'Debugger', ->
        div id: 'visual', ->
          "<div id='visualfps' /> <div id='visualbar'/><br/>"
        div id: 'sim', ->
          "<div id='simulatorfps' /> <div id='simbar'/>"

    @_template_compiled = coffeekup.compile(@_template)

    @output = @_template_compiled()

    jQuery('body').append(@output)
    
    @visual = jQuery('#visualfps')
    @sim = jQuery('#simulatorfps')
    @bar1 = jQuery('#visualbar').progressbar({ 'value': (@game._timerVisual.percentage() * 100) | 0 })
    @bar2 = jQuery('#simbar').progressbar({ 'value': (@game._timerSimulator.percentage() * 100) | 0 })

    @dialog = jQuery('#debugger').dialog({ 'autoOpen': false })
    @dialog.dialog('open')


  update: =>
    @visual.html("visual: #{@game._timerVisual.fps().toFixed(2)} fps")
    @sim.html("sim: #{@game._timerSimulator.fps().toFixed(2)} fps")
    @bar1.progressbar('option', 'value', (@game._timerVisual.percentage() * 100) | 0)
    @bar2.progressbar('option', 'value', (@game._timerSimulator.percentage() * 100) | 0)

