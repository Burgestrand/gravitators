class @Vec2
  @Origin = new Vec2(0, 0)
  @Identity = new Vec2(1, 1)

  @polar = (angle, length) ->
    x = Math.cos(angle) * length
    y = Math.sin(angle) * length
    new @(x, y)

  constructor: (@x, @y) ->

  length: ->
    Math.sqrt @dot(this)

  angle: ->
    Math.atan2(@y, @x)

  rad2deg = 180 / Math.PI
  angled: ->
    @angle() * rad2deg

  dot: ({ x, y }) ->
    @x * x + @y * y

  rotate: (r) ->
    x = @x * Math.cos(r) - @y * Math.sin(r)
    y = @x * Math.sin(r) + @y * Math.cos(r)
    new Vec2(x, y)

  add: ({ x, y }) ->
    new Vec2(@x + x, @y + y)

  sub: ({ x, y }) ->
    new Vec2(@x - x, @y - y)

  mul: ({ x, y }) ->
    new Vec2(@x * x, @y * y)

  muls: (n) ->
    @mul({ x: n, y: n })

  toString: ->
    "(#{@x},#{@y})"
