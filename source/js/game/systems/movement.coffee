class Systems.Movement extends System
  constructor: ->

  update: ->
    for { position, velocity } in @engine.entities.withComponents("position", "velocity")
      vec2.add(position, position, velocity)
