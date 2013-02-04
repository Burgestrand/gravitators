#= require ./model

class @Point extends Model
  @property "x", "y"

  @read: (x, y) ->
    if x.x? and x.y?
      new this(x.x, x.y)
    else if x? and y?
      new this(x, y)
    else if x?
      new this(x, x)
    else
      throw new Error("Must supply either point, x and y, or x!")

  @vector: (length, direction) ->
    d = Math.deg2rad(direction)
    l = length
    new this(Math.cos(d) * l, Math.sin(d) * l)

  constructor: (@x, @y) ->

  add: ->
    p = Point.read(arguments...)
    new @constructor(@x + p.x, @y + p.y)

  toJSON: ->
    { @x, @y }

  toString: ->
    "(#{@x},#{@y})"
