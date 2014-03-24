#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game

document.addEventListener "DOMContentLoaded", =>
  @game = new Game()
  renderer = @game.register(new RenderingSystem(640, 640))
  document.body.appendChild(renderer.canvas)
  @game.start()

  ticker = ->
    output = []
    for { system } in @game.systems
      [ticks, system.ticks] = [system.ticks, 0]
      output.push "#{system.constructor.name}: #{ticks}"
    console.log output.join(", ")

  setInterval(ticker, 1000)

