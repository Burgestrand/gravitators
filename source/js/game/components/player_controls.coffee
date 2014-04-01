allocator = ->
  { accelerate: null, retardate: null, left: null, right: null, shoot: null }
initializer = (controls, [config]) ->
  for action of controls
    controls[action] = config[action]

Components.PlayerControls = new SimplePool(allocator, initializer)
