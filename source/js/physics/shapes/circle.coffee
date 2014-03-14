class @Physics.Circle extends Physics.Shape
  @attribute "radius", value: -> 1

  @property "BS", get: ->
    this

  draw: ({ context }) ->
    context.arc(0, 0, @radius, 0, 2 * Math.PI, true)
    context.stroke()
