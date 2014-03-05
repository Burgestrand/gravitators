class @Vec2
  constructor: (@x, @y) ->

  length: ->
    Math.sqrt @dot(this)

  dot: ({ x, y }) ->
    @x * x + @y * y

  add: ({ x, y }) ->
    new Vec2(@x + x, @y + y)

  sub: ({ x, y }) ->
    new Vec2(@x - x, @y - y)
