#= require_self
#= require_directory ./monkey_patches
#= require_directory ./math
#= require ./physics
#= require ./rendering
#= require_directory ./game

document.addEventListener "DOMContentLoaded", =>
  @physics = new Physics.Engine(320, 320)
  @renderer = new Rendering.Renderer(@physics)
  document.body.appendChild(@renderer.canvas)
  @renderer.resize()

  @loop = new Loop(@physics.tick, @renderer.render)
  @loop.start(60)

  @renderer.canvas.addEventListener "click", (event) =>
    clicked = new Vec2(event.offsetX, event.offsetY)
    clicked.x -= @renderer.currentTransform.translateX
    clicked.y -= @renderer.currentTransform.translateY

    circle = new Physics.Circle(3)
    body = new Physics.Body(shape: circle, position: clicked)
    @physics.bodies.push(body)
