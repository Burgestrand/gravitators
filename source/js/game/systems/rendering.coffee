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

    for id, info of @engine.entities.withComponents([Components.Position, Components.Shape])
      { position } = info["Position"]
      { radius } = info["Shape"].shape

      @drawing.save()
      @drawing.translate(position)
      @context.beginPath()
      @context.arc(0, 0, radius, 0, Math.PI * 2, false)
      @context.stroke()
      @context.closePath()

      @drawing.restore()

    @_draw = null

  update: (delta) ->
    @_draw or= requestAnimationFrame(@draw)
