class Systems.TerminalVelocity extends System
  constructor: (@terminalVelocity) ->
    @squaredTerminalVelocity = @terminalVelocity * @terminalVelocity
    @origo = vec2.fromValues(0, 0)

  update: ->
    for id, entity of @engine.entities.withComponents("velocity")
      { velocity } = entity

      squaredLength = vec2.squaredLength(velocity)
      if squaredLength > @squaredTerminalVelocity
        vec2.lerp(velocity, velocity, @origo, 1 - (@squaredTerminalVelocity / squaredLength))
