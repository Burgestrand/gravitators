#= require_self
#= require_directory ./monkey_patches
#= require_directory ./math
#= require_directory ./game
#= require ./physics

document.addEventListener "DOMContentLoaded", =>
  @physics = new Physics.Engine(620, 620)
  @renderer = new Physics.Renderer(@physics)
  document.body.appendChild(@renderer.canvas)
  @renderer.resize()

  @loop = new Loop(@physics.tick, @renderer.render)
  @loop.start(60)

  @renderer.canvas.addEventListener "click", (event) =>
    clicked = new Vec2(event.offsetX, event.offsetY)
    clicked = clicked.itransform(@renderer.currentTransform)
    x = Math.random() * 100
    xs = (Math.random() - 0.5).signum()
    y = Math.random() * 100
    ys = (Math.random() - 0.5).signum()
    velocity = new Vec2(x * xs, y * ys)
    body = new Ship(velocity: velocity, position: clicked)

    @physics.bodies.push(body)

    shape = if Math.random() > 0.5
      new Physics.Circle(position: clicked, radius: 10)
    else
      new Physics.Rectangle(position: clicked, width: 10, height: 10)

    x = Math.random() * 100
    xs = (Math.random() - 0.5).signum()
    y = Math.random() * 100
    ys = (Math.random() - 0.5).signum()
    velocity = new Vec2(x * xs, y * ys)
    body = new Physics.Body(shape: shape, velocity: velocity)

    @physics.bodies.push(body)
