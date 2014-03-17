class @Player extends Actor
  @attribute "body", value: -> new Ship()
  @delegate "color", to: "body"

  @attribute "weapon", value: ->
    new Weapon(speed: 100, owner: this)

  @attribute "speed", value: -> 200
  @attribute "turnSpeed", value: -> Math.PI

  # Accelerate, Turn Left, Turn Right, Retardate, Shoot
  @attribute "controls", value: ->
    ["w", "a", "d", "s", "space"]

  @property "weaponThrottler", get: ->
    @_weaponThrottler ?= new Throttler(@shootSpeed)

  update: (fps, engine) ->
    [up, left, right, down, shoot] = @controls

    # Rotate
    rotates = if key.isPressed(left) then 1
    else if key.isPressed(right) then -1
    else 0
    rotation = (@turnSpeed * rotates) / fps
    @body.direction += rotation

    # Accelerate (or retardate)
    accelerates = if key.isPressed(up) then 1
    else if key.isPressed(down) then -1
    else 0
    acceleration = Vec2.polar(@body.direction, (@speed * accelerates) / fps)
    @body.force.add(acceleration)

    # Shoot
    @weapon.update(fps, engine) if key.isPressed(shoot)
