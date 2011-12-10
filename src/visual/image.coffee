class IImage
  constructor: (@data) ->
    @position = { 'x': 0, 'y': 0 }
    @priority = 0


  draw: (canvas) =>
    canvas.drawImage(@data, @position.x, @position.y)

