allocator = ->
  {
    accelerate: null,
    retardate: null,
    left: null,
    right: null,
    shoot: null,
    accelerationSpeed: 0.1,
    rotationSpeed: Math.deg2rad(2),
  }
initializer = (controls, [config]) ->
  Object.update(controls, config)

Components.ShipControls = new SimplePool(allocator, initializer)
