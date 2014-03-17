class @Physics.Rectangle extends Physics.Shape
  @attribute "width", value: -> 0
  @attribute "height", value: -> 0

  @property "BS", get: ->
    radius = Math.max(@width, @height) / 2
    new Physics.BoundingSphere(shape: this, radius: radius)

  draw: ({ context }) ->
    x = -(@width / 2)
    y = -(@height / 2)
    context.rect(x, y, @width, @height)
    context.stroke()
