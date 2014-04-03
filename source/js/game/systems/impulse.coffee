class Systems.Impulse extends System
  constructor: ->
    @force = vec2.create()

  update: ->
    for { velocity, impulse } in @engine.entities.withComponents("velocity", "impulse")
      vec2.add(velocity, velocity, impulse)
      vec2.clear(impulse)
