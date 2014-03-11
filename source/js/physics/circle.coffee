class @Physics.Circle extends Physics.Shape
  @attribute "radius", value: -> 1

  draw: (renderer) ->
    renderer.context.arc(0, 0, @radius, 0, 2 * Math.PI, true)
    renderer.context.stroke()
