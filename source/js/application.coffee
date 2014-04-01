#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game/engine

document.addEventListener "DOMContentLoaded", =>
  engine = new Engine()
  engine.attach("movement", new Systems.Movement, fps: 120)
  engine.attach("collisions", new Systems.Collisions, fps: 120)
  engine.attach("rendering", new Systems.Rendering(640, 640), fps: 60)
  engine.systems["rendering"].appendTo(document.body)

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

  engine.entities.create "Player", (info) ->
    info["model"].color = "red"
    info["rotationSpeed"] = Math.PI
    vec2.set(info["position"], (Math.random() * 640) - 320, Math.random() * 320)

  @engine = engine
