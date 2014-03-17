class Physics.Engine
  constructor: (@width, @height) ->
    @bounds = [new Plane2(1, 0, @width / 2),
               new Plane2(0, -1, @height / 2),
               new Plane2(-1, 0, @width / 2),
               new Plane2(0, 1, @height / 2)]
    @actors = []
    @gravity = new Vec2(0, -50)

  addActor: (actor) ->
    @actors.push(actor)

  removeActor: (actor) ->
    index = @actors.indexOf(actor)
    @actors.splice(index, 1) if index isnt -1

  update: (fps) =>
    # Update all actors
    @actors.forEach (actor) =>
      actor.update(fps, this)

    # Accelerate and move all bodies
    @actors.forEach ({ body }) =>
      gravity = @gravity.clone().muls(body.gravityScale).divs(fps)
      body.force.add(gravity)
      body.velocity.add(body.force)
      body.force.clear()

      velocity = body.velocity.clone().divs(fps)
      body.position.add(velocity)

    # Check for collisions
    collisions = {}
    event = {}

    @actors = @actors.filter (actor, index) =>
      { BS } = actor.body

      collisions[index] or= []

      for edge in @bounds
        if (edge.distance(BS.position) - BS.radius) < 0
          collisions[index].push(edge)

      for otherIndex in [index + 1...@actors.length]
        otherActor = @actors[otherIndex]
        otherBody = otherActor.body
        otherBS = otherBody.BS
        distance = BS.position.clone().sub(otherBS.position)
        radii = BS.radius + otherBS.radius
        if distance.lengthSquared() <= radii * radii
          collisions[otherIndex] or= []
          collisions[otherIndex].push(actor)
          collisions[index].push(otherActor)

      collided = false

      for collision in collisions[index]
        event.prevented = false
        event.collision = collision
        actor.collide(event, this)
        collided or= not event.prevented

      # keep if
      not collided
