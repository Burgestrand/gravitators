class Systems.Gravity extends System
  constructor: (@gravity) ->

  update: ->
    for id, entity of @engine.entities.withComponents("impulse", "gravity")
      { impulse } = entity

      vec2.add(impulse, impulse, @gravity)
