class Systems.TerminalVelocity extends System
  constructor: (@terminalVelocity) ->
    @negativeTerminalVelocity = vec2.create()
    vec2.negate(@negativeTerminalVelocity, @terminalVelocity)

  update: ->
    for id, entity of @engine.entities.withComponents("velocity")
      { velocity } = entity

      if velocity[0] > @terminalVelocity[0]
        velocity[0] = @terminalVelocity[0]

      if velocity[0] < @negativeTerminalVelocity[0]
        velocity[0] = @negativeTerminalVelocity[0]

      if velocity[1] > @terminalVelocity[1]
        velocity[1] = @terminalVelocity[1]

      if velocity[1] < @negativeTerminalVelocity[1]
        velocity[1] = @negativeTerminalVelocity[1]
