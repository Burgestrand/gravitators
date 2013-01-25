class @Player extends Serenade.Model
  @property "speed", value: 4
  @property "controls", value: {}

  @property "ship"
    get: ->
      @_ship
    set: (ship) ->
      ship.position = @position if @position
      @_ship = ship
      @shape?.onTick = => @tick(arguments...)

  @delegate "shape", "position", "x", "y", "rotation", to: "ship"

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
    vector = Point.vector(length, @rotation)
    @position = @position.add(vector)
