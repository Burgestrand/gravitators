class @Physics.Body extends GameObject
  @attribute "shape", value: -> new Physics.Circle(1)
  @delegate "position", to: "shape"
  @delegate "BS", to: "shape"

  @attribute "velocity", value: -> new Vec2(0, 0)
  @attribute "acceleration", value: -> new Vec2(0, 0)
  @attribute "gravityScale", value: -> 1

  draw: (renderer) ->
    @shape?.draw(renderer)
