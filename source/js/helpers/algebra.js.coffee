#= require ./model

class @Point extends Model
  @read: (x, y) ->
    if x.x? and x.y?
      new this(x.x, x.y)
    else if x? and y?
      new this(x, y)
    else if x?
      new this(x, x)
    else
      throw new Error("Must supply either point, x and y, or x!")

  @vector: (length, angle) ->
    a = angle
    l = length
    new this(Math.cos(a) * l, Math.sin(a) * l)

  @property "x",
    get: ->
      @_x
    set: (x) ->
      @_x = Math.round(x, 2)

  @property "y",
    get: ->
      @_y
    set: (y) ->
      @_y = Math.round(y, 2)

  @property "length",
    get: ->
      Math.sqrt(@x * @x + @y * @y)
    set: (length) ->
      angle = @angle
      @x = Math.cos(angle) * length
      @y = Math.sin(angle) * length

  @property "angle",
    get: ->
      Math.atan2(@y, @x)
    set: (angle) ->
      length = @length
      @x = Math.cos(angle) * length
      @y = Math.sin(angle) * length

  constructor: (@x, @y) ->

  multiply: (scalar) ->
    clone = @clone()
    clone.length *= scalar
    clone

  add: ->
    p = Point.read(arguments...)
    new @constructor(@x + p.x, @y + p.y)

  dotproduct: (vector) ->
    angle = vector.angle - @angle
    Math.cos(angle) * vector.length

  clone: ->
    new Point(@x, @y)

  toJSON: ->
    { @x, @y }

  toString: ->
    "(#{@x},#{@y})"
