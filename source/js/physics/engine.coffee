class Physics.Engine
  constructor: (@width, @height) ->
    @bounds = [new Plane2(1, 0, @width / 2),
               new Plane2(0, -1, @height / 2),
               new Plane2(-1, 0, @width / 2),
               new Plane2(0, 1, @height / 2)]
    @actors = []
    @gravity = vec2.fromValues(0, -50)

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
      gravity = vec2.clone(@gravity)
      vec2.multiply(gravity, gravity, vec2.fromValue(body.gravityScale))
      vec2.divide(gravity, gravity, vec2.fromValue(fps))

      vec2.add(body.force, body.force, gravity)
      vec2.add(body.velocity, body.velocity, body.force)
      vec2.set(body.force, 0, 0)

      velocity = vec2.clone(body.velocity)
      vec2.divide(velocity, velocity, vec2.fromValue(fps))
      vec2.add(body.position, body.position, velocity)

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
        distance = vec2.clone(BS.position)
        vec2.subtract(distance, distance, otherBS.position)
        radii = BS.radius + otherBS.radius
        if vec2.squaredLength(distance) <= radii * radii
          collisions[otherIndex] or= []
          collisions[otherIndex].push(actor)
          collisions[index].push(otherActor)

      collided = false

      for entity in collisions[index]
        event.prevented = false
        event.entity = entity
        actor.collide(event, this)
        collided or= not event.prevented

      # keep if
      not collided
