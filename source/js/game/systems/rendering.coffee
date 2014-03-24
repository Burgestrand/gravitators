class System.Rendering extends System
  constructor: (@width, @height) ->
    @canvas = document.createElement("canvas")
    @canvas.width = @width
    @canvas.height = @height
    @drawing = new CanvasAPI(@canvas)
    @context = @drawing.context

  appendTo: (node) ->
    node.appendChild(@canvas)
    @canvas.width = @canvas.offsetWidth
    @canvas.height = @canvas.offsetHeight

    op = vec2.fromValues(@canvas.width / 2, @canvas.height / 2)
    @drawing.translate(op)
    op = vec2.fromValues(1, -1)
    @drawing.scale(op)

  draw: =>
    @drawing.clear()
    for own id, descriptor of @engine.entities.entitiesWith(["Position", "Renderable"])
      p = descriptor["Position"].position

      @context.beginPath()
      @context.arc(p[0], p[1], 3, 0, Math.PI * 2, false)
      @context.stroke()
      @context.closePath()

    @_draw = null

  update: (delta) ->
    @_draw or= requestAnimationFrame(@draw)
