class @Player extends Actor
  @attribute "body", value: -> new Ship()
  @delegate "color", to: "body"

  @attribute "speed", value: -> 200
  @attribute "turnSpeed", value: -> Math.PI

  # Accelerate, Turn Left, Turn Right, Retardate
  @attribute "controls", value: ->
    ["up", "left", "right", "down"]

  update: (fps, engine) ->
    [up, left, right, down] = @controls

    rotates = if key.isPressed(left) then 1
    else if key.isPressed(right) then -1
    else 0
    rotation = (@turnSpeed * rotates) / fps
    @body.direction += rotation

    accelerates = if key.isPressed(up) then 1
    else if key.isPressed(down) then -1
    else 0
    acceleration = vec2.polar(@body.direction, (@speed * accelerates) / fps)
    vec2.add(@body.force, @body.force, acceleration)
