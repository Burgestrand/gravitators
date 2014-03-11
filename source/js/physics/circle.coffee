class @Physics.Circle extends Physics.Shape
  @attribute "radius", value: -> 1

  draw: ({ context }) ->
    context.arc(@position.x, @position.y, @radius, 0, 2 * Math.PI, true)
    context.stroke()
