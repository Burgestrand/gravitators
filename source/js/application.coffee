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

  translation = new Vec2(canvas.width / 2, canvas.height / 2)
  context.setTransform(1, 0, 0, 1, translation.x, translation.y)

  edges = [new Plane2(1, 0, 200), new Plane2(0, -1, 200), new Plane2(-1, 0, 200), new Plane2(0, 1, 200)]
  context.point({ x: 0, y: 0 }, "black")
  colors = ["red", "green", "blue", "orange"]
  edges.forEach (e, idx) ->
    context.plane(e, colors[idx])

  canvas.addEventListener "click", (event) ->
    clicked = new Vec2(event.offsetX, event.offsetY).sub(translation)
    edgeIndex = edges.findIndex (edge) ->
      edge.distance(clicked) < 0
    context.point(clicked, colors[edgeIndex] ? "white")

  @canvas = canvas
  @context = context
  @world = new World(canvas.width / 2, canvas.height / 2)
