class Systems.TerminalVelocity extends System
  constructor: ->
    @origo = vec2.fromValues(0, 0)

  update: ->
    for { velocity, terminalVelocity } in @engine.entities.withComponents("terminalVelocity", "velocity")
      squaredLength = vec2.length(velocity)
      squaredTerminalVelocity = terminalVelocity * terminalVelocity
      if squaredLength > squaredTerminalVelocity
        vec2.lerp(velocity, velocity, @origo, 1 - (squaredTerminalVelocity / squaredLength))
