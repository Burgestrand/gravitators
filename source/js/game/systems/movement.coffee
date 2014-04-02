class Systems.Movement extends System
  constructor: ->

  update: ->
    for id, entity of @engine.entities.withComponents("position", "velocity")
      { position, velocity } = entity

      vec2.add(position, position, velocity)
