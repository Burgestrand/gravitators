class @Vec2
  @polar = (angle, length) ->
    x = Math.cos(angle) * length
    y = Math.sin(angle) * length
    new @(x, y)

  constructor: (@x, @y) ->

  set: ({ @x, @y }) ->
    this

  clear: ->
    @x = 0
    @y = 0
    this

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
    @x = x
    @y = y
    this

  add: ({ x, y }) ->
    @x += x
    @y += y
    this

  sub: ({ x, y }) ->
    @x -= x
    @y -= y
    this

  mul: ({ x, y }) ->
    @x *= x
    @y *= y
    this

  div: ({ x, y }) ->
    @x /= x
    @y /= y
    this

  adds: (n) ->
    @x += n
    @y += n
    this

  subs: (n) ->
    @x -= n
    @y -= n
    this

  muls: (n) ->
    @x *= n
    @y *= n
    this

  divs: (n) ->
    @x /= n
    @y /= n
    this

  transform: (m) ->
    x = m.scaleX * @x + m.shearX * @y + m.translateX # ax + bx + c
    y = m.shearY * @x + m.scaleY * @y + m.translateY # dy + ey + f
    @x = x
    @y = y
    this

  itransform: (m) ->
    determinant = m.scaleX * m.scaleY - m.shearX * m.shearY
    if determinant is 0
      throw new Error("inverse transform of #{@} with #{m} is not possible")
    x_ = @x - m.translateX
    y_ = @y - m.translateY
    @x = (x_ * m.scaleY - y_ * m.shearX) / determinant
    @y = (y_ * m.scaleX - x_ * m.shearY) / determinant
    this

  toString: ->
    x = Math.round(@x, 2)
    y = Math.round(@y, 2)
    "(#{x},#{y})"
