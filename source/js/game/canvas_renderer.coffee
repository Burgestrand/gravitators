class @CanvasRenderer
  constructor: (@engine, @width, @height) ->
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

  update: (delta) ->
    @drawing.clear()

    for id, info of @engine.entities.withComponents("position", "model")
      { position, rotation, model } = info

      @drawing.save()
      @drawing.translate(position)
      @drawing.rotate(rotation) if rotation
      @context.beginPath()

      switch model.type
        when "circle"
          @context.arc(0, 0, model.radius, 0, Math.PI * 2, true)
        when "polygon"
          vec2.forEach model.points, 0, 0, 0, (v) =>
            @context.lineTo(v[0], v[1])

      @context.fillStyle = model.color
      @context.strokeStyle = "black"
      @context.fill()
      @context.stroke()

      @context.closePath()
      @drawing.restore()
