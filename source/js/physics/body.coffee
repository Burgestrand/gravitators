class @Physics.Body extends GameObject
  @attribute "shape", value: -> new Physics.Circle(radius: 1)
  @delegate "position", to: "shape"
  @delegate "BS", to: "shape"

  @attribute "velocity", value: -> vec2.fromValues(0, 0)

  @attribute "force", value: -> vec2.fromValues(0, 0)
  @attribute "gravityScale", value: -> 1

  draw: (renderer) ->
    @shape?.draw(renderer)
