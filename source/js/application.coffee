#= require_self
#= require_directory ./vendor
#= require_directory ./monkey_patches
#= require_directory ./math
#= require ./game
#= require ./physics

document.addEventListener "DOMContentLoaded", =>
  @physics = new Physics.Engine(620, 620)
  @renderer = new Physics.Renderer(@physics)
  document.body.appendChild(@renderer.canvas)
  @renderer.resize()

  @loop = new Loop(@physics.update, @renderer.render)
  @loop.start(60)

  @renderer.canvas.addEventListener "click", (event) =>
    clicked = new Vec2(event.offsetX, event.offsetY)
    clicked = clicked.itransform(@renderer.currentTransform)
    x = Math.random() * 100
    xs = (Math.random() - 0.5).signum()
    y = Math.random() * 100
    ys = (Math.random() - 0.5).signum()
    velocity = new Vec2(x * xs, y * ys)
    ship = new Ship(velocity: velocity, position: clicked)

    @physics.addActor(new Actor(body: ship))

  key "p", =>
    if not @loop.running
      @loop.start()
    else
      @loop.stop()

  key "1,2", (event, handler) =>
    controls =
      1: ["w", "a", "d", "s"]
      2: ["up", "left", "right", "down"]
    colors =
      1: "#069"
      2: "#930"
    player = new Player(controls: controls[handler.key], color: colors[handler.key])
    @physics.addActor(player)

@spawn = (n = 1) =>
  for i in [0...n]
    s = @physics.width * 0.8
    x = (Math.random() * s - s / 2)
    y = (Math.random() * s - s / 2)
    position = new Vec2(x, y)

    shape = if Math.random() > 0.5
      new Physics.Circle(position: position, radius: 10)
    else
      new Physics.Rectangle(position: position, width: 10, height: 10)

    x = Math.random() * 100
    xs = (Math.random() - 0.5).signum()
    y = Math.random() * 100
    ys = (Math.random() - 0.5).signum()
    velocity = new Vec2(x * xs, y * ys)
    body = new Physics.Body({ shape, velocity })
    actor = new Actor({ body })

    @physics.addActor(actor)
