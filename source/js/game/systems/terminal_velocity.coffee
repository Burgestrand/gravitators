class Systems.TerminalVelocity extends System
  constructor: ->
    @origo = vec2.fromValues(0, 0)

  update: ->
    for id, entity of @engine.entities.withComponents("terminalVelocity", "velocity")
      { velocity, terminalVelocity } = entity

      squaredLength = vec2.length(velocity)
      squaredTerminalVelocity = terminalVelocity * terminalVelocity
      if squaredLength > squaredTerminalVelocity
        vec2.lerp(velocity, velocity, @origo, 1 - (squaredTerminalVelocity / squaredLength))
