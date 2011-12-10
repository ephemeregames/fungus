class Canvas2D  
  constructor: (@size) ->

    @canvas = $('<canvas />', {
      id: 'canvas2d'
    })

    # here because we don't want to set the css attribute with .width()...
    @canvas.attr('width', @size.x + 'px')
    @canvas.attr('height', @size.y + 'px')

    @canvas.css('position', 'absolute')
    @canvas.css('left', '0px')
    @canvas.css('right', '0px')
    
    $('body').append(@canvas)
    
    @context = (@canvas[0]).getContext '2d'
    
    this.fullscreen()

      
  draw: (items) =>
    # clear screen
    @context.clearRect 0, 0, @size.x, @size.y
    # @context.fillStyle = '#000000'
    # @context.fillRect 0, 0, @size.x, @size.y
    
    items.sort(this._sortByPriority)

    item.draw(@context) for item in items


  _sortByPriority: (x, y) =>
    return y.priority - x.priority


  resize: (size) =>
    @size = size
    @canvas.attr('width', @size.x + 'px')
    @canvas.attr('height', @size.y + 'px')
    this.fullscreen()


  fullscreen: =>
    w = $(window)
    
    # there is a difference between element.width and element.css.width...
    @canvas.css('width', w.width())
    @canvas.css('height', w.height())
