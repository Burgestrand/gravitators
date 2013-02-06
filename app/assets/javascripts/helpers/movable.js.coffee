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
      @_velocity?.clone() or new Point(0, 0)
    set: (velocity) ->
      @_velocity = Point.read(velocity)

  @property "acceleration", value: 200
  @property "maxVelocity", value: 600

  @property "revolution", value: Math.deg2rad(360)

  tick: (timeElapsed) ->
    @move(timeElapsed)

  move: (duration) ->
    vector = @velocity
    vector.length *= (duration / 1000)
    @position = @position.add(vector)

  accelerate: (duration) ->
    length   = duration * (@acceleration / 1000)
    movement = Point.vector(length, @rotation)
    velocity = @velocity.add(movement)
    velocity.length = Math.min(velocity.length, @maxVelocity)
    @velocity = velocity

  retardate: (duration) ->
    @accelerate(-1 * duration)

  rotate: (duration, positive) ->
    angle = @revolution * (duration / 1000)
    angle *= -1 if not positive
    @rotation += angle

  collidesWith: (point) ->
    point = @shape.globalToLocal(point.x, point.y)
    @shape.hitTest(point.x, point.y)
