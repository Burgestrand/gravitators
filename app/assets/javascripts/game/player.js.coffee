class @Player extends Model
  @property "controls", value: {}

  @property "ship"
    get: ->
      @_ship
    set: (ship) ->
      if @ship
        ship.position = @position
        ship.rotation = @rotation
      @_ship = ship

  @forward "position", "weapon", "rotation", "velocity", to: "ship"

  @property "shape"
    get: ->
      container = new c.Container(@ship.shape, @weapon?.shape)
      container.onTick = => @tick(arguments...)
      container

  constructor: (@ship, @controls) ->
    key Object.values(@controls).join(","), "playing", (event) ->
      event.preventDefault()

  tick: (timeElapsed) ->
    @ship.rotate(-.1 * timeElapsed) if key.isPressed(@controls.left)
    @ship.rotate(+.1 * timeElapsed) if key.isPressed(@controls.right)

    if key.isPressed(@controls.accelerate)
      @ship.accelerate(timeElapsed)
    else if key.isPressed(@controls.retardate)
      @ship.retardate(timeElapsed)

    @ship.shoot(timeElapsed) if key.isPressed(@controls.shoot)
