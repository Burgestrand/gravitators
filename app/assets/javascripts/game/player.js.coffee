class @Player extends Serenade.Model
  @property "controls", value: {}

  @property "ship"
    get: ->
      @_ship
    set: (ship) ->
      ship.position = @position if @position
      ship.rotation = @rotation if @rotation
      ship.shape.onTick = => @tick(arguments...)
      @_ship = ship

  @delegate "shape", "weapon", "position", "rotation", "speed", to: "ship"

  constructor: (@ship, @controls) ->
    key Object.values(@controls).join(","), "playing", (event) ->
      event.preventDefault()

  tick: (timeElapsed) ->
    timeElapsed *= 0.1
    @rotation -= 5 * timeElapsed if key.isPressed(@controls.left)
    @rotation += 5 * timeElapsed if key.isPressed(@controls.right)
    @move(@speed * timeElapsed) if key.isPressed(@controls.accelerate)

  move: (length) ->
    @ship.move(length)
