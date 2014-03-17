class @Ship extends Physics.Body
  @attribute "shape", value: ->
    length = 16
    width = 10

    points = [
      new Vec2(0, 0),
      new Vec2(-(length / 2), width),
      new Vec2(length, 0),
      new Vec2(-(length / 2), -width),
      new Vec2(0, 0)
    ]
    new Physics.Polygon({ points })

  @attribute "color", value: -> "#900"

  draw: ({ context }) ->
    context.strokeStyle = "black"
    super
    context.fillStyle = @color
    context.fill()
