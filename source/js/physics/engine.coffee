class Physics.Engine
  constructor: (@width, @height) ->
    @bounds = [new Plane2(1, 0, @width / 2),
               new Plane2(0, -1, @height / 2),
               new Plane2(-1, 0, @width / 2),
               new Plane2(0, 1, @height / 2)]
    @bodies = []
    @gravity = new Vec2(0, -9.82)

  tick: (delta) =>
    fps = 1000 / delta

    bodies = @bodies[0..-1]
    bodies.forEach (body, index) =>
      # Integration
      gravity = @gravity.muls(body.gravityScale)
      moved = body.velocity.divs(fps)
      accelerated = body.acceleration.add(gravity).divs(fps)
      { BS } = body

      body.position = body.position.add(moved)
      body.velocity = body.velocity.add(accelerated)

      collidingEdges = @bounds.findAll (edge) ->
        (edge.distance(BS.position) - BS.radius) < 0

      collidingBodies = bodies[index + 1..-1].findAll (otherBody, otherIndex) =>
        otherBS = otherBody.BS
        distance = BS.position.sub(otherBS.position)
        radii = BS.radius + otherBS.radius
        distance.lengthSquared() <= radii * radii

      # TODO: do something sensible
      if collidingEdges.length or collidingBodies.length
        @bodies.splice(index, 1)
