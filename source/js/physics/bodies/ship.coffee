class @Ship extends Physics.Body
  @attribute "shape", value: ->
    length = 16
    width = 10

    points = [
      vec2.fromValues(0, 0),
      vec2.fromValues(-(length / 2), width),
      vec2.fromValues(length, 0),
      vec2.fromValues(-(length / 2), -width),
      vec2.fromValues(0, 0)
    ]
    new Physics.Polygon({ points })

  @attribute "color", value: -> "#900"
  @attribute "direction", value: -> 0

  draw: (renderer) ->
    context = renderer.context
    context.strokeStyle = "black"
    context.fillStyle = @color

    renderer.rotate(@direction)
    super
    context.fill()
