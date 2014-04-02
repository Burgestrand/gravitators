class Systems.Maneuvering extends System
  constructor: (@input) ->
    @force = vec2.create()

  update: ->
    for id, entity of @engine.entities.withComponents("impulse", "rotation", "controls")
      { controls, impulse, rotation } = entity

      if @input.isPressed(controls.accelerate)
        vec2.polar(@force, rotation, controls.accelerationSpeed)
        vec2.add(impulse, impulse, @force)

      if @input.isPressed(controls.retardate)
        vec2.polar(@force, rotation, controls.accelerationSpeed)
        vec2.sub(impulse, impulse, @force)

      if @input.isPressed(controls.left)
        entity.rotation += controls.rotationSpeed

      if @input.isPressed(controls.right)
        entity.rotation -= controls.rotationSpeed
