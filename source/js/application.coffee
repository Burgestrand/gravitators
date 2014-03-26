#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game/engine

document.addEventListener "DOMContentLoaded", =>
  @engine = new Engine()
  @renderer = @engine.register(new System.Rendering(640, 640))
  @renderer.appendTo(document.body)
  @engine.start()

  count = 100
  timer = setInterval ->
    clearInterval(timer) if count-- <= 0
    for index in [1..10]
      id = @engine.entities.create("Bullet")
      bullet = @engine.entities[id]
      radius = Math.round(Math.random() * 7 + 1)
      bullet["Shape"].shape.radius = radius

      length = Math.round(Math.random() * 320)
      vec2.random(bullet["Position"].position, length)
  , 10
