class Text
  constructor: (@data = '') ->
    @color = '#FF0000'
    @position = { 'x': 0, 'y': 0 }
    @size = 20
    @font = 'Lucida Sans Unicode'
    @priority = 0

  draw: (canvas) =>
    canvas.font = "#{@size}pt #{@font}"
    canvas.fillStyle = @color
    canvas.fillText @data, @position.x, @position.y

