class @Plane2
  constructor: (@a, @b, @c) ->
    @n = new Vec2(@a, @b)
    @d = @c

  distance: (p) ->
    p.dot(@n) + @d

  intersection: ({ a, b, c }) ->
    denom = (@a * b - @b * a)

    unless denom is 0
      x = (@c * b - @b * c) / denom
      y = (@a * c - @c * a) / denom
      new Vec2(-x, -y)

  toString: ->
    "#{@n}@#{@d}"
