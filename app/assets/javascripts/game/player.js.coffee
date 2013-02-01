class @Player extends Model
  @property "controls", value: {}

  @property "ship"
    get: ->
      @_ship
    set: (ship) ->
      if @ship
        ship.position = @position
        ship.rotation = @rotation
      ship.shape.onTick = => @tick(arguments...)
      @_ship = ship

  @forward "position", "weapon", "rotation", "speed", to: "ship"

  @property "shape"
    get: ->
      new c.Container(@ship.shape, @weapon?.shape)

  constructor: (@ship, @controls) ->
    key Object.values(@controls).join(","), "playing", (event) ->
      event.preventDefault()

  tick: (timeElapsed) ->
    timeElapsed *= 0.1
    @ship.rotate(-1 * timeElapsed) if key.isPressed(@controls.left)
    @ship.rotate(+1 * timeElapsed) if key.isPressed(@controls.right)
    @ship.move(timeElapsed) if key.isPressed(@controls.accelerate)
    @ship.shoot(timeElapsed) if key.isPressed(@controls.shoot)
