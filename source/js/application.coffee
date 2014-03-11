#= require_self
#= require_directory ./monkey_patches
#= require_directory ./math
#= require_directory ./game
#= require ./physics
#= require ./rendering

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
    circle = new Physics.Circle(position: clicked, radius: 10)

    x = Math.random() * 100
    xs = (Math.random() - 0.5).signum()
    y = Math.random() * 100
    ys = (Math.random() - 0.5).signum()
    velocity = new Vec2(x * xs, y * ys)
    body = new Physics.Body(shape: circle, velocity: velocity)

    @physics.bodies.push(body)
