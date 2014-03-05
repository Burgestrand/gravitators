#= require_self
#= require_directory ./physics

document.addEventListener "DOMContentLoaded", =>
  canvas = document.createElement("canvas")
  document.body.appendChild(canvas)

  canvas.width = canvas.offsetWidth
  canvas.height = canvas.offsetHeight

  context = canvas.getContext("2d")
  context.font = "16px Helvetica Neue"
  context.clear ?= ->
    @save()
    @setTransform(1, 0, 0, 1, 0, 0) # identity matrix
    @clearRect(0, 0, @canvas.width, @canvas.height)
    @restore()

  @canvas = canvas
  @context = context
