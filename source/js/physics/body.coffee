class @Physics.Body
  constructor: ->
    @shape = { volume: 0 }
    @material = { density: 0, restitution: 0 }
    @velocity = new Vec2(0, 0)
    @force = new Vec2(0, 0)
    @gravityScale = 1

    @mass = @material.density * @shape.volume
    @inv_mass = 1 / @mass
