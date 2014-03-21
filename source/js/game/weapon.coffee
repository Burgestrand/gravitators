class @Weapon extends GameObject
  @attribute "owner"
  @attribute "speed", value: -> 100

  @property "throttler", get: ->
    @_throttler or= new Throttler(@speed)

  update: (fps, engine) ->
    @throttler.invoke =>
      ownerBody = @owner.body
      bulletSpeed = 100

      position = vec2.polar(ownerBody.direction, ownerBody.BS.radius + 1)
      vec2.add(position, position, ownerBody.position)

      velocity = vec2.polar(ownerBody.direction, bulletSpeed)
      vec2.add(velocity, velocity, ownerBody.velocity)

      bullet = new Bullet({ position, velocity })
      engine.addActor(bullet)
