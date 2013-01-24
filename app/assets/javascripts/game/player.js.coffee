class @Player extends Serenade.Model
  @property "speed", value: 4
  @property "controls", value: {}

  @property "position"
    get: ->
      new Point(@x, @y)
    set: (point) ->
      { @x, @y } = point

  @property "ship"
    get: ->
      @_ship
    set: (value) ->
      position = @position  # save previous position
      @shape?.onTick = null # clear previous handler
      @_ship = value
      @position = position
      @shape?.onTick = => @tick(arguments...)

  @delegate "shape", to: "ship"
  @delegate "x", "y", "rotation", to: "shape"

  constructor: (@ship, @controls) ->
    @position = { x: 200, y: 200 }

    key Object.values(@controls).join(","), "playing", (event) ->
      event.preventDefault()

  tick: (timeElapsed) ->
    timeElapsed *= 0.1
    @rotation -= 5 * timeElapsed if key.isPressed(@controls.left)
    @rotation += 5 * timeElapsed if key.isPressed(@controls.right)
    @move(@speed * timeElapsed) if key.isPressed(@controls.accelerate)

  move: (length) ->
    { x, y } = new Vector(length, @rotation).point
    @x += x
    @y += y
