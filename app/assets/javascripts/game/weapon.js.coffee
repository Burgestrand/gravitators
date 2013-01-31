class Bullet extends Movable
  @Lifetime = 200

  constructor: ->
    radius = 2
    @shape = new c.Shape()
    @shape.graphics
      .beginFill("#202020")
      .drawCircle(radius, radius, radius)
      .endFill()
    @shape.regX = radius
    @shape.regY = radius
    @position = Point.read(arguments...)
    @expiration = Bullet.Lifetime

  tick: (timeElapsed) ->
    @expiration -= timeElapsed
    @shape?.alpha = @expiration / Bullet.Lifetime
    @expiration

class @Weapon extends Serenade.Model
  @property "shape"

  constructor: ->
    @shape = new c.Container()
    @shape.onTick = => @tick(arguments...)
    @bullets = []

  tick: (timeElapsed) ->
    @bullets = @bullets.filter((bullet) -> bullet.tick(timeElapsed) > 0)
    @shape.removeAllChildren()
    @shape.addChild(@bullets.map((o) -> o.shape)...)

  shoot: (origin) ->
    bullet = new Bullet(origin)
    @shape.addChild(bullet.shape)
    @bullets.push(bullet)
