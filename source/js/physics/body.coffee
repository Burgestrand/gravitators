class @Physics.Body extends GameObject
  @attribute "shape", value: -> new Physics.Circle(radius: 1)
  @delegate "position", to: "shape"
  @delegate "BS", to: "shape"

  @attribute "velocity", value: -> new Vec2(0, 0)
  @attribute "direction", value: -> 0

  @attribute "force", value: -> new Vec2(0, 0)
  @attribute "gravityScale", value: -> 1

  draw: (renderer) ->
    renderer.transform (matrix) =>
      matrix.translate(@position)
      matrix.rotate(@direction)
    @shape?.draw(renderer)
