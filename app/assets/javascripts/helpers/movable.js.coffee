class @Movable extends Model
  @property "shape"
    get: ->
      @_shape
    set: (shape) ->
      @_shape = shape
      @_shape.onTick = => @tick(arguments...)

  @forward "x", "y", to: "shape"

  @property "rotation"
    get: ->
      Math.deg2rad(@shape.rotation)
    set: (angle) ->
      @shape.rotation = Math.rad2deg(angle)

  @property "position"
    get: ->
      new Point(@x, @y)
    set: (point) ->
      { @x, @y } = Point.read(point)

  @property "velocity"
    get: ->
      @_velocity or 0
    set: (velocity) ->
      @_velocity = Math.constrain(velocity, -@maxVelocity, @maxVelocity)

  @property "revolution", value: Math.deg2rad(360)
  @property "maxVelocity", value: 600

  tick: (timeElapsed) ->
    @move(timeElapsed)

  move: (duration) ->
    length = @velocity * (duration / 1000)
    vector = Point.vector(length, @rotation)
    @position = @position.add(vector)

  rotate: (duration, positive) ->
    angle = @revolution * (duration / 1000)
    angle *= -1 if not positive
    @rotation += angle
