allocator = ->
  {
    accelerate: null,
    retardate: null,
    left: null,
    right: null,
    shoot: null,
    accelerationSpeed: 40,
    rotationSpeed: Math.deg2rad(10),
  }
initializer = (controls, [config]) ->
  Object.update(controls, config)

Components.ShipControls = new SimplePool(allocator, initializer)
