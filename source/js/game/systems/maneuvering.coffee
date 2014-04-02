class Systems.Maneuvering extends System
  constructor: (@input) ->
    @force = vec2.create()

  update: (delta) ->
    @deltaV or= vec2.fromValue(delta)

    for id, entity of @engine.entities.withComponents("controls")
      { controls, velocity, rotation } = entity

      if @input.isPressed(controls.accelerate)
        vec2.polar(@force, rotation, controls.accelerationSpeed / delta)
        vec2.divide(@force, @force, @deltaV)
        vec2.add(velocity, velocity, @force)

      if @input.isPressed(controls.retardate)
        vec2.polar(@force, rotation, controls.accelerationSpeed / delta)
        vec2.divide(@force, @force, @deltaV)
        vec2.sub(velocity, velocity, @force)

      if @input.isPressed(controls.left)
        entity.rotation += controls.rotationSpeed / delta

      if @input.isPressed(controls.right)
        entity.rotation -= controls.rotationSpeed / delta
