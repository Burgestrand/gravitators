class @Bullet extends Movable
  @Lifetime = 2000

  constructor: (origin, rotation) ->
    radius = 2
    @shape = new c.Shape()
    @shape.graphics
      .beginFill("#202020")
      .drawCircle(radius, radius, radius)
      .endFill()
    @shape.cache(0, 0, radius * 2, radius * 2)
    @shape.regX = radius
    @shape.regY = radius
    @position = origin
    @rotation = rotation
    @expiration = Bullet.Lifetime

  tick: (timeElapsed) ->
    @expiration -= timeElapsed
    @shape?.alpha = @expiration / Bullet.Lifetime
    @move(timeElapsed * 0.6)
    @expiration
