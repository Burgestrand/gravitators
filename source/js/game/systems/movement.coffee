class Systems.Movement extends System
  constructor: ->
    @vector = vec2.create()

  update: (delta) ->
    @fps or= vec2.fromValues(delta, delta)

    for id, info of @engine.entities.withComponents("position", "velocity")
      { position, velocity } = info

      vec2.divide(@vector, velocity, @fps)
      vec2.add(position, position, @vector)
