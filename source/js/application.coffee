#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game

document.addEventListener "DOMContentLoaded", =>
  @game = new Game()
  @renderer = @game.register(new System.Rendering(640, 640))
  @renderer.appendTo(document.body)
  @game.start()

  @game.entities.create("Bullet")
