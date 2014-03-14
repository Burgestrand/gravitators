class @Physics.Body extends GameObject
  @attribute "shape", value: -> new Physics.Circle(radius: 1)
  @delegate "position", to: "shape"
  @delegate "BS", to: "shape"

  @attribute "velocity", value: -> new Vec2(0, 0)

  @attribute "force", value: -> new Vec2(0, 0)
  @attribute "gravityScale", value: -> 1

  draw: (renderer) ->
    renderer.transform (matrix) =>
      matrix.translate(@position)
    @shape?.draw(renderer)
