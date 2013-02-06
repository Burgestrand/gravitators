class @Bullet extends Movable
  @Lifetime = 5000

  constructor: ->
    radius = 2
    @shape = new c.Shape()
    @shape.graphics
      .beginFill("#202020")
      .drawCircle(radius, radius, radius)
      .endFill()
    @shape.cache(0, 0, radius * 2, radius * 2)
    @shape.regX = radius
    @shape.regY = radius
    super
    @expiration = Bullet.Lifetime

  tick: (timeElapsed) ->
    super
    @expiration -= timeElapsed
    @shape?.alpha = @expiration / Bullet.Lifetime
    @expiration
