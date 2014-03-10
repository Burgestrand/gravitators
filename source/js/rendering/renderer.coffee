class Rendering.Renderer
  constructor: (@engine) ->
    @canvas = document.createElement("canvas")
    @currentTransform = new Rendering.Transform
    @context = @canvas.getContext("2d")
    @context.font = "16px Helvetica Neue"

  render: (bleed) =>
    @clear()

    @point({ x: 0, y: 0 }, "black")

    @engine.bounds.forEach (plane) =>
      @line(plane)

    @engine.bodies.forEach (body) ->
      body.draw(this)

  isolate: (fn) ->
    @context.save()
    fn()
    @context.restore()

  clear: ->
    @isolate =>
      @_setTransform(Rendering.Transform.Identity)
      @context.clearRect(0, 0, @canvas.width, @canvas.height)

  path: (fn) ->
    @isolate =>
      @context.beginPath()
      fn()
      @context.closePath()

  point: ({ x, y }, color = "#000000") ->
    @path =>
      @context.fillStyle = color
      @context.arc(x, y, 3, 0, 2 * Math.PI, true)
      @context.stroke()
      @context.fill()

  line: ({ n, d }) ->
    @path =>
      nr = n.rotate(Math.PI / 2)
      origin = Vec2.polar(n.angle() + Math.PI, d)
      from = origin.add(nr.muls(d))
      to = origin.add(nr.muls(-d))

      @context.moveTo(from.x, from.y)
      @context.lineTo(to.x, to.y)
      @context.stroke()

      @point(origin, "black")
      @point(from, "white")
      @point(to, "white")

  resize: ->
    @canvas.width = @canvas.offsetWidth
    @canvas.height = @canvas.offsetHeight

    # center the origin
    @_transform (matrix) ->
      matrix.translateX = @canvas.width * 0.5
      matrix.translateY = @canvas.height * 0.5

  _transform: (fn) ->
    fn.call(@, @currentTransform) if fn
    @_setTransform(@currentTransform)

  _setTransform: (matrix) ->
    @context.setTransform(matrix.scaleX, matrix.shearX, matrix.shearY, matrix.scaleY, matrix.translateX, matrix.translateY)
