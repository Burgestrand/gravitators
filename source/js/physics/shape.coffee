class @Physics.Shape extends GameObject
  @attribute "position", value: -> new Vec2(0, 0)

  draw: (renderer) ->
    throw new Error("draw not implemented")
