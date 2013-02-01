class @Weapon extends Model
  @property "shape"

  constructor: ->
    @shape = new c.Container()
    @shape.onTick = => @tick(arguments...)
    @bullets = []

  tick: (timeElapsed) ->
    removed = for bullet, index in @bullets
      if bullet.tick(timeElapsed) <= 0
        index
      else
        continue

    if removed.length > 0
      @bullets.splice(0, removed.length)
      @shape.removeChildAt(removed...)

  shoot: (ship) ->
    bullet = new Bullet(position: ship.tip, rotation: ship.rotation)
    bullet.velocity = 200 + Math.constrain(ship.velocity, -160, 160)
    @shape.addChild(bullet.shape)
    @bullets.push(bullet)
