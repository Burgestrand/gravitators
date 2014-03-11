class Physics.Engine
  constructor: (@width, @height) ->
    @bounds = [new Plane2(1, 0, @width * 0.9),
               new Plane2(0, -1, @height * 0.9),
               new Plane2(-1, 0, @width * 0.9),
               new Plane2(0, 1, @height * 0.9)]
    @bodies = []
    @gravity = new Vec2(0, 9.82)

  tick: (delta) =>
    fps = 1000 / delta
    @bodies.forEach (body, index) =>
      # Calculate displacement
      gravity = @gravity.muls(body.gravityScale)
      moved = body.velocity.divs(fps)
      accelerated = body.acceleration.add(gravity).divs(fps)
      body.position = body.position.add(moved)
      body.velocity = body.velocity.add(accelerated)

      # Check if body is out of bounds
      if @bounds.some((edge) -> edge.distance(body.position) < 0)
        @bodies.splice(index, 1)
