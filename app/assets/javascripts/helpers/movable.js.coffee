class @Movable extends Serenade.Model
  @property "shape"
  @forward "x", "y", "rotation", to: "shape"

  @property "position"
    get: ->
      new Point(@x, @y)
    set: (point) ->
      { @x, @y } = Point.read(point)

  @property "speed", value: 4

  move: (length) ->
    vector = Point.vector(length, @rotation)
    @position = @position.add(vector)

