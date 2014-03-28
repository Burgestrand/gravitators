#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game/engine

document.addEventListener "DOMContentLoaded", =>
  engine = new Engine()
  engine.register(new Systems.Movement, fps: 120)
  engine.register(new Systems.Collisions, fps: 120)
  renderer = engine.register(new Systems.Rendering(640, 640), fps: 60)
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

  creator = ->
    engine.entities.create "Bullet", (id, info) ->
      info["shape"].radius = 5
      vec2.set(info["velocity"], 0, -10)
      vec2.set(info["position"], (Math.random() * 640) - 320, Math.random() * 320)

  setInterval(creator, 100)

  @engine = engine
