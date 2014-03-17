class @Player extends Actor
  @attribute "body", value: -> new Ship()
  @delegate "color", to: "body"

  @attribute "speed", value: -> 200
  @attribute "turnSpeed", value: -> Math.PI
  @attribute "shootSpeed", value: -> 100

  # Accelerate, Turn Left, Turn Right, Retardate, Shoot
  @attribute "controls", value: ->
    ["w", "a", "d", "s", "space"]

  @property "weaponThrottler", get: ->
    @_weaponThrottler ?= new Throttler(@shootSpeed)

  update: (fps, engine) ->
    [up, left, right, down, shoot] = @controls

    rotates = if key.isPressed(left) then 1
    else if key.isPressed(right) then -1
    else 0
    rotation = (@turnSpeed * rotates) / fps
    @body.direction += rotation

    accelerates = if key.isPressed(up) then 1
    else if key.isPressed(down) then -1
    else 0
    acceleration = Vec2.polar(@body.direction, (@speed * accelerates) / fps)
    @body.force.add(acceleration)

    if key.isPressed(shoot)
      @weaponThrottler.invoke =>
        speed = 100
        position = Vec2.polar(@body.direction, @body.BS.radius + 1).add(@body.position)
        velocity = Vec2.polar(@body.direction, 100).add(@body.velocity)
        bullet = new Bullet({ position, velocity })

        engine.addActor(bullet)
