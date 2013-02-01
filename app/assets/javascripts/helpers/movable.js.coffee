class @Movable extends Model
  @property "shape"
    get: ->
      @_shape
    set: (shape) ->
      @_shape = shape
      @_shape.onTick = => @tick(arguments...)

  @forward "x", "y", "rotation", to: "shape"

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

  @property "revolution", value: 4
  @property "maxVelocity", value: 600

  tick: (timeElapsed) ->
    @move(timeElapsed)

  move: (duration) ->
    if @velocity
      length = duration * (@velocity / 1000)
      vector = Point.vector(length, @rotation)
      @position = @position.add(vector)

  rotate: (degrees) ->
    @rotation += @revolution * degrees
