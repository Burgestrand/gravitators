#= require_self
#= require_directory ./monkey_patches
#= require_directory ./math
#= require ./physics
#= require ./rendering
#= require_directory ./game

document.addEventListener "DOMContentLoaded", =>

  @engine = new Physics.Engine(320, 320)
  @renderer = new Rendering.Renderer(@engine)
  document.body.appendChild(@renderer.canvas)
  @renderer.resize()

  @loop = new Loop(@engine.tick, @renderer.render)
  @loop.start(60)

  @renderer.canvas.addEventListener "click", (event) =>
    clicked = new Vec2(event.offsetX, event.offsetY)
    clicked.x -= @renderer.currentTransform.translateX
    clicked.y -= @renderer.currentTransform.translateY
    edgeIndex = @engine.bounds.findIndex (edge) ->
      edge.distance(clicked) < 0
    @renderer.point(clicked)
