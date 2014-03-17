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

    @bodies.forEach (body) =>
      force = new Vec2(0, 0)
      force.add(@gravity).muls(body.gravityScale).add(body.force).divs(fps)
      body.velocity.add(force)

      velocity = new Vec2(0, 0)
      velocity.set(body.velocity).divs(fps)
      body.position.add(velocity)

    destroyed = {}

    collider = (body, index) =>
      { BS } = body

      collidingEdge = @bounds.find (edge) ->
        (edge.distance(BS.position) - BS.radius) < 0

      destroyed[index] or= collidingEdge

      for otherIndex in [index + 1...@bodies.length]
        otherBody = @bodies[otherIndex]
        otherBS = otherBody.BS
        distance = new Vec2(0, 0)
        distance.set(BS.position).sub(otherBS.position)
        radii = BS.radius + otherBS.radius
        if distance.lengthSquared() <= radii * radii
          destroyed[index] or= otherBody
          destroyed[otherIndex] or= body

      if destroyed[index]
        body.collide?(destroyed[index], this)
        false
      else
        true

    @bodies = @bodies.filter(collider)
