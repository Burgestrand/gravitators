#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game/engine

document.addEventListener "DOMContentLoaded", =>
  engine = new Engine()
  engine.renderer = new CanvasRenderer(engine, 640, 640)
  engine.renderer.appendTo(document.body)

  engine.attach("maneuvering", new Systems.Maneuvering(key))
  engine.attach("gravity", new Systems.Gravity(vec2.fromValues(0, -0.02)))
  engine.attach("lifetime", new Systems.Lifetime)
  engine.attach("impulse", new Systems.Impulse)
  engine.attach("terminalVelocity", new Systems.TerminalVelocity)

  engine.attach("movement", new Systems.Movement)
  engine.attach("collisions", new Systems.Collisions(640, 640))

  key "p", (event) ->
    event.preventDefault()

    if engine.running
      engine.stop()
    else
      engine.start()

  unless document.hidden
    engine.start()

  playpause = ->
    if document.hidden
      console.log "Tab lost focus. Pausing."
      engine.stop()

  document.addEventListener "webkitvisibilitychange", playpause
  document.addEventListener "mozvisibilitychange", playpause
  document.addEventListener "msvisibilitychange", playpause

  engine.entities.create Entities.Player, Entities.PlayerAControls, (entity) ->
    entity["model"].color = "red"
    entity["rotationSpeed"] = Math.PI
    vec2.set(entity["position"], (Math.random() * 640) - 320, Math.random() * 320)

  engine.entities.create Entities.Player, Entities.PlayerBControls, (entity) ->
    entity["model"].color = "blue"
    vec2.set(entity["position"], (Math.random() * 640) - 320, Math.random() * 320)

  # creator = ->
  #   engine.entities.create Entities.Bullet, (entity) ->
  #     vec2.set(entity["velocity"], 0, (0.6 + Math.random() * 2) * -1)
  #     entity["model"].radius = 2 * vec2.squaredLength(entity["velocity"])
  #     vec2.set(entity["position"], (Math.random() * 640) - 320, Math.random() * 320)

  # setInterval(creator, 10)

  @engine = engine
