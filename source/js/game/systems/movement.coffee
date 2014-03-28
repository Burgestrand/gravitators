class Systems.Movement extends System
  constructor: ->

  update: (delta) ->
    @fps or= vec2.fromValues(delta, delta)

    for id, info of @engine.entities.withComponents("position", "velocity", "force")
      { position, velocity, force } = info

      vec2.divide(force, velocity, @fps)
      vec2.add(position, position, force)
      vec2.clear(force)