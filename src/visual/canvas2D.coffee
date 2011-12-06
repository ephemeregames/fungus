class Canvas2D  
  constructor: (@container) ->
    #tmp
    canvas = document.createElement('canvas')
    canvas.setAttribute('id', 'canvas')
    canvas.style.position = 'absolute'
    canvas.style.left = '0px'
    canvas.style.right = '0px'
    document.body.appendChild(canvas)

    @context = canvas.getContext '2d'
    @width = @context.canvas.width
    @height = @context.canvas.height

      
  draw: (items) =>
    # clear screen
    @context.clearRect 0, 0, @width, @height
    # @context.fillStyle = '#000000'
    # @context.fillRect 0, 0, @width, @height
    
    item.draw(@context) for item in items


  resize: =>
    @width = @context.canvas.width = window.innerWidth
    @height = @context.canvas.height = window.innerHeight

