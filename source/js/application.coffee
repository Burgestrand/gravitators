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

  @engine.entities.create("Bullet")
