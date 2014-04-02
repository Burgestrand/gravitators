class Systems.Collisions extends System
  constructor: (@width, @height) ->

  update: ->
    for id, info of @engine.entities.withComponents("position", "model")
      { position, model } = info

      x = position[0]
      y = position[1]
      radius = model.boundingSphere.radius

      if (x + radius) > (@width / 2) || (x - radius) < -(@width / 2) || (y + radius) > (@height / 2) || (y - radius) < -(@height / 2)
        @engine.entities.release(id)
        # console.log("Crash!")
