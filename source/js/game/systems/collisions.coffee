class Systems.Collisions extends System
  update: ->
    { width, height } = @engine.systems["Rendering"]

    for id, info of @engine.entities.withComponents("position", "velocity", "shape")
      { position, shape } = info
      radius = shape.radius

      x = position[0]
      y = position[1]

      if (x + radius) > (width / 2) || (x - radius) < -(width / 2) || (y + radius) > (height / 2) || (y - radius) < -(height / 2)
        @engine.entities.release(id)
        console.log "Crash!"
