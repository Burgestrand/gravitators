class @Physics.Rectangle extends Physics.Shape
  @attribute "width", value: -> 0
  @attribute "height", value: -> 0

  @property "BS", get: ->
    position = @position
    radius = Math.max(@width, @height) / 2
    new Physics.Circle({ position, radius })

  draw: ({ context }) ->
    x = @position.x - (@width / 2)
    y = @position.y - (@height / 2)
    context.rect(x, y, @width, @height)
    context.stroke()
