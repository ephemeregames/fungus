class Text
  constructor: (@data = '') ->
    @color = '#FF0000'
    @position = [0, 0]
    @size = 20
    @font = 'Lucida Sans Unicode'

  draw: (canvas) =>
    canvas.font = "#{@size}pt #{@font}"
    canvas.fillStyle = @color
    canvas.fillText @data, @position[0], @position[1]

