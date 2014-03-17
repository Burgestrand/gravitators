class @Bullet extends Actor
  @attribute "body", value: ->
    shape = new Physics.Circle(radius: 1)
    gravityScale = 0
    new Physics.Body({ shape, gravityScale })

  @delegate "position", to: "body"
  @delegate "velocity", to: "body"

  @attribute "TTL", value: -> 5000

  collide: (collision, engine) ->
    if collision.entity instanceof Bullet
      collision.prevented = true

  update: (fps, engine) ->
    @aliveUntil ?= performance.now() + @TTL

    if performance.now() >= @aliveUntil
      engine.removeActor(this)
