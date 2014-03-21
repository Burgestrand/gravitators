class @Physics.Shape extends GameObject
  @attribute "position", value: -> vec2.fromValues(0, 0)

  @property "BS", get: ->
    throw new Error("not implemented")

  draw: (renderer) ->
    throw new Error("draw not implemented")
