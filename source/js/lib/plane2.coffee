class @Plane2
  constructor: (@a, @b, @c) ->
    @n = vec2.fromValues(@a, @b)
    @d = @c

  distance: (p) ->
    vec2.dot(p, @n) + @d

  intersection: ({ a, b, c }) ->
    denom = (@a * b - @b * a)

    unless denom is 0
      x = (@c * b - @b * c) / denom
      y = (@a * c - @c * a) / denom
      vec2.fromValues(-x, -y)

  toString: ->
    "#{@n}@#{@d}"
