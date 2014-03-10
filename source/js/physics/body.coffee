class @Physics.Body
  constructor: ({ shape, position, velocity, acceleration } = {}) ->
    @shape = shape
    @position = position ? new Vec2(0, 0)
    @velocity = velocity ? new Vec2(0, 0)
    @acceleration = acceleration ? new Vec2(0, 0)

  draw: (renderer) ->
    renderer._transform (matrix) =>
      matrix.translateX += @position.x
      matrix.translateY += @position.y
    @shape?.draw(renderer)
