class @Weapon extends GameObject
  @attribute "owner"
  @attribute "speed", value: -> 100

  @property "throttler", get: ->
    @_throttler or= new Throttler(@speed)

  update: (fps, engine) ->
    @throttler.invoke =>
      ownerBody = @owner.body
      bulletSpeed = 100
      position = Vec2.polar(ownerBody.direction, ownerBody.BS.radius + 1).add(ownerBody.position)
      velocity = Vec2.polar(ownerBody.direction, bulletSpeed).add(ownerBody.velocity)
      bullet = new Bullet({ position, velocity })
      engine.addActor(bullet)
