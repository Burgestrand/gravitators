#= require_self
#= require_directory ./monkey_patches
#= require_directory ./physics
#= require_directory ./rendering

document.addEventListener "DOMContentLoaded", =>
  canvas = document.createElement("canvas")
  document.body.appendChild(canvas)

  canvas.width = canvas.offsetWidth
  canvas.height = canvas.offsetHeight

  context = canvas.getContext("2d")
  context.font = "16px Helvetica Neue"

  context.setTransform(1, 0, 0, 1, canvas.width / 2, canvas.height / 2)

  LARGE = 100000
  planes = [[new Vec2(1, 0), 200], [new Vec2(0, -1), 200], [new Vec2(-1, 0), 200], [new Vec2(0, 1), 200]]
  context.point({ x: 0, y: 0 }, "black")
  colors = ["red", "green", "blue", "orange"]
  planes.forEach ([ n, d ], idx) ->
    context.plane(n, d, colors[idx])

  @canvas = canvas
  @context = context
  @world = new World(canvas.width / 2, canvas.height / 2)
