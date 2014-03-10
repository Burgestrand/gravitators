#= require_self
#= require_directory ./monkey_patches
#= require_directory ./math
#= require ./physics
#= require ./rendering
#= require_directory ./game

document.addEventListener "DOMContentLoaded", =>
  renderer = new Rendering.Renderer
  document.body.appendChild(renderer.canvas)
  renderer.resize()

  { canvas, context } = renderer

  @world = new Physics.World(canvas.width, canvas.height)
  @renderer = renderer

  context.point({ x: 0, y: 0 }, "black")
  colors = ["red", "green", "blue", "orange"]
  @world.bounds.forEach (plane, idx) ->
    context.plane(plane, colors[idx])

  canvas.addEventListener "click", (event) ->
    clicked = new Vec2(event.offsetX, event.offsetY)
    clicked.x -= renderer.currentTransform.translateX
    clicked.y -= renderer.currentTransform.translateY
    edgeIndex = edges.findIndex (edge) ->
      edge.distance(clicked) < 0
    context.point(clicked, colors[edgeIndex] ? "white")
