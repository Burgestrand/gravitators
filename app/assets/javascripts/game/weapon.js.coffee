class @Weapon extends Model
  @property "shape"

  @property "cooldown", value: 250

  @property "gametime"
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
      sv = ship.velocity
      trajectory = Point.vector(ship.maxVelocity * 1.2, ship.rotation)

      da = sv.angle - trajectory.angle
      scalar = Math.cos(da) * sv.length

      trajectory.length += scalar

      bullet = new Bullet(position: ship.tip, velocity: trajectory)
      @bullets.push(bullet)
      @lastShot = @gametime
