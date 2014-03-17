class @Physics.Circle extends Physics.Shape
  @attribute "radius", value: -> 1

  @property "BS", get: ->
    new Physics.BoundingSphere(shape: this, radius: @radius)

  draw: ({ context }) ->
    context.arc(0, 0, @radius, 0, 2 * Math.PI, true)
    context.stroke()
