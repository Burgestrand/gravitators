#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./lib
#= require ./game
#= require ./physics

document.addEventListener "DOMContentLoaded", =>
  @physics = new Physics.Engine(640, 640)
  @renderer = new Physics.Renderer(@physics)
  document.body.appendChild(@renderer.canvas)
  @renderer.resize()

  @loop = new Loop(@physics.update, @renderer.render)
  @loop.start(60)

  key "p", =>
    if not @loop.running
      @loop.start()
    else
      @loop.stop()

  key "1,2", (event, handler) =>
    controls =
      1: ["w", "a", "d", "s", "space"]
      2: ["up", "left", "right", "down", "enter"]
    colors =
      1: "#069"
      2: "#930"
    player = new Player(controls: controls[handler.key], color: colors[handler.key])
    @physics.addActor(player)
