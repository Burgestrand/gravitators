class @Plane2
  constructor: (@a, @b, @c) ->
    @n = new Vec2(@a, @b)
    @d = @c

  distance: (p) ->
    p.dot(@n) + @d

  toString: ->
    "#{@n}@#{@d}"
