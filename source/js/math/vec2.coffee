class @Vec2
  @Origin = new Vec2(0, 0)
  @Identity = new Vec2(1, 1)

  @polar = (angle, length) ->
    x = Math.cos(angle) * length
    y = Math.sin(angle) * length
    new @(x, y)

  constructor: (@x, @y) ->

  length: ->
    Math.sqrt(@lengthSquared())

  lengthSquared: ->
    @dot(this)

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

  div: ({ x, y }) ->
    new Vec2(@x / x, @y / y)

  adds: (n) ->
    @add({ x: n, y: n })

  subs: (n) ->
    @sub({ x: n, y: n })

  muls: (n) ->
    @mul({ x: n, y: n })

  divs: (n) ->
    @div({ x: n, y: n })

  transform: (m) ->
    x = m.scaleX * @x + m.shearX * @y + m.translateX # ax + bx + c
    y = m.shearY * @x + m.scaleY * @y + m.translateY # dy + ey + f
    new Vec2(x, y)

  itransform: (m) ->
    x = (@x - m.translateX) * (1 / m.scaleX)
    y = (@y - m.translateY) * (1 / m.scaleY)
    # Solve for x, and y:
    # @x - m.translateX = m.scaleX * x + m.shearX * y
    # @y - m.translateY = m.shearY * x + m.scaleY * y
    new Vec2(x, y)

  toString: ->
    x = Math.round(@x, 2)
    y = Math.round(@y, 2)
    "(#{x},#{y})"
