class Systems.Impulse extends System
  constructor: ->
    @force = vec2.create()

  update: ->
    for id, entity of @engine.entities.withComponents("velocity", "impulse")
      { velocity, impulse } = entity

      vec2.add(velocity, velocity, impulse)
      vec2.clear(impulse)
