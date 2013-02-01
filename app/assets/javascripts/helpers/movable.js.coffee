class @Movable extends Model
  @property "shape"
  @forward "x", "y", "rotation", to: "shape"

  @property "position"
    get: ->
      new Point(@x, @y)
    set: (point) ->
      { @x, @y } = Point.read(point)

  @property "speed", value: 4
  @property "revolution", value: 4

  move: (length) ->
    vector = Point.vector(@speed * length, @rotation)
    @position = @position.add(vector)

  rotate: (length) ->
    @rotation += @revolution * length
