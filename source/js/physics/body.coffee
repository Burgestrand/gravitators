class @Physics.Body
  constructor: (@shape) ->
    @position = new Vec2(0, 0)
    @velocity = new Vec2(0, 0)
    @acceleration = new Vec2(0, 0)
