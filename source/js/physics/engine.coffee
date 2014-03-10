class Physics.Engine
  constructor: (@width, @height) ->
    @bounds = [new Plane2(1, 0, @width * 0.9),
               new Plane2(0, -1, @height * 0.9),
               new Plane2(-1, 0, @width * 0.9),
               new Plane2(0, 1, @height * 0.9)]
    @bodies = []
    @gravity = new Vec2(0, 9.82)

  tick: (delta) =>
    @bodies.forEach (body, index) =>
      movement = body.velocity.divs(delta)
      body.position = body.position.add(movement)

      # Check if body is out of bounds
      if @bounds.some((edge) -> edge.distance(body.position) < 0)
        @bodies.splice(index, 1)
