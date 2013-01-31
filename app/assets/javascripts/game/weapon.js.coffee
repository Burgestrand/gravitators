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

  shoot: (origin, rotation) ->
    bullet = new Bullet(origin, rotation)
    @shape.addChild(bullet.shape)
    @bullets.push(bullet)
