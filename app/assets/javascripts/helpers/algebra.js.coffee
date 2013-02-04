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

  @property "x", "y"
  constructor: (@x, @y) ->

  add: ->
    p = Point.read(arguments...)
    new @constructor(@x + p.x, @y + p.y)

  toJSON: ->
    { @x, @y }

  toString: ->
    "(#{@x},#{@y})"
