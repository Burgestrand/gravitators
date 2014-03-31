#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game/engine

document.addEventListener "DOMContentLoaded", =>
  engine = new Engine()
  engine.register("movement", new Systems.Movement, fps: 120)
  engine.register("collisions", new Systems.Collisions, fps: 120)
  engine.register("rendering", new Systems.Rendering(640, 640), fps: 60)
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



  @engine = engine
