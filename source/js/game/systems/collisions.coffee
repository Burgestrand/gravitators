class Systems.Collisions extends System
  constructor: (@width, @height) ->

  update: ->
    for entity in @engine.entities.withComponents("position", "model")
      { position, model } = entity

      x = position[0]
      y = position[1]
      radius = model.boundingSphere.radius

      if (x + radius) > (@width / 2) || (x - radius) < -(@width / 2) || (y + radius) > (@height / 2) || (y - radius) < -(@height / 2)
        @engine.entities.release(entity.id)
        # console.log("Crash!")
