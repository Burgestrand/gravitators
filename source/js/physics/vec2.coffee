class @Vec2
  @Origin = new Vec2(0, 0)
  @Id = new Vec2(1, 1)

  constructor: (@x, @y) ->

  length: ->
    Math.sqrt @dot(this)

  dot: ({ x, y }) ->
    @x * x + @y * y

  add: ({ x, y }) ->
    new Vec2(@x + x, @y + y)

  sub: ({ x, y }) ->
    new Vec2(@x - x, @y - y)
