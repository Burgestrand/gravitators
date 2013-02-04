class @Weapon extends Model
  @property "shape"

  @property "cooldown", value: 250

  @property "gametime"
    get: ->
      c.Ticker.getTime(true)

  constructor: ->
    @shape = new c.Container()
    @shape.onTick = => @tick(arguments...)
    @lastShot = -Infinity
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
    if @gametime > @lastShot + @cooldown
      bullet = new Bullet(position: ship.tip, rotation: ship.rotation)
      bullet.velocity = 200 + Math.constrain(ship.velocity, -160, 160)
      @shape.addChild(bullet.shape)
      @bullets.push(bullet)
      @lastShot = @gametime
