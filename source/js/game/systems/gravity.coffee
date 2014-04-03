class Systems.Gravity extends System
  constructor: (@gravity) ->

  update: ->
    for { impulse } in @engine.entities.withComponents("impulse", "gravity")
      vec2.add(impulse, impulse, @gravity)
