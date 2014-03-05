class @Weapon extends Model
  @property "shape"

  @property "cooldown", value: 250

  @property "gametime",
    get: ->
      c.Ticker.getTime(true)

  constructor: ->
    @bullets = new Container()
    @shape = @bullets.shape
    @shape.onTick = => @tick(arguments...)
    @lastShot = -Infinity

  tick: (timeElapsed) ->
    removed = for bullet, index in @bullets
      if bullet.tick(timeElapsed) <= 0
        index
      else
        continue

    if removed.length > 0
      @bullets.splice(0, removed.length)

  shoot: (ship) ->
    if @gametime > @lastShot + @cooldown
      velocity = Point.vector(ship.maxVelocity * 1.2, ship.rotation)
      velocity.length += velocity.dotproduct(ship.velocity)
      bullet = new Bullet(position: ship.tip, velocity: velocity)
      @bullets.push(bullet)
      @lastShot = @gametime
