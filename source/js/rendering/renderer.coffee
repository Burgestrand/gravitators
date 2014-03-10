class Rendering.Renderer
  constructor: (@physics) ->
    @canvas = document.createElement("canvas")
    @currentTransform = new Rendering.Transform
    @context = @canvas.getContext("2d")
    @context.font = "16px Helvetica Neue"

  render: (bleed) =>
    @clear()

    @point({ x: 0, y: 0 }, "black")

    colors = ["red", "green", "blue", "magenta"]

    @physics.bounds.forEach (bound, idx) =>
      points = []

      @edges.forEach (edge) =>
        point = bound.intersection(edge)
        points.push(point) if point

      points.sort (p, a) ->
        p.lengthSquared() - a.lengthSquared()

      a = points[0]
      b = points[1]

      @path =>
        @context.strokeStyle = colors[idx]
        @context.moveTo(a.x, a.y)
        @context.lineTo(b.x, b.y)
        @context.stroke()

    @physics.bodies.forEach (body) ->
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

  line: ({ n, d }, color = "#000000") ->
    @path =>
      @context.strokeStyle = color

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

    @edges = [new Plane2(1, 0, @canvas.width * 0.5),
              new Plane2(0, -1, @canvas.height * 0.5),
              new Plane2(-1, 0, @canvas.width * 0.5),
              new Plane2(0, 1, @canvas.height * 0.5)]

    # center the origin
    @_transform (matrix) ->
      matrix.translateX = @canvas.width * 0.5
      matrix.translateY = @canvas.height * 0.5

  _transform: (fn) ->
    fn.call(@, @currentTransform) if fn
    @_setTransform(@currentTransform)

  _setTransform: (matrix) ->
    @context.setTransform(matrix.scaleX, matrix.shearX, matrix.shearY, matrix.scaleY, matrix.translateX, matrix.translateY)
