#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game/engine

document.addEventListener "DOMContentLoaded", =>
  engine = new Engine()
  engine.register(new System.Movement, fps: 120)
  renderer = engine.register(new System.Rendering(640, 640), fps: 60)
  renderer.appendTo(document.body)

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

  engine.entities.create "Bullet", (bullet) ->
    bullet["Shape"].shape.radius = 5
    vec2.set(bullet["Velocity"].velocity, 0, -10)

  @engine = engine
  @renderer = renderer
