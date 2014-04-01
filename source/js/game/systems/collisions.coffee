class Systems.Collisions extends System
  update: ->
    { width, height } = @engine.systems["rendering"]
    boundingSphere = { radius: null }

    for id, info of @engine.entities.withComponents("position", "model")
      { position, model } = info

      switch model.type
        when "circle"
          boundingSphere.radius = model.radius
        when "polygon"
          max = 0
          vec2.forEach model.points, null, null, null, (v) ->
            len = vec2.squaredLength(v)
            if len > max
              max = len
          boundingSphere.radius = Math.sqrt(max)

      x = position[0]
      y = position[1]
      radius = boundingSphere.radius

      if (x + radius) > (width / 2) || (x - radius) < -(width / 2) || (y + radius) > (height / 2) || (y - radius) < -(height / 2)
        @engine.entities.release(id)
        console.log("Crash!")
