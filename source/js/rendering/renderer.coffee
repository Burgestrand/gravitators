class Rendering.Renderer
  constructor: (@physics) ->
    @canvas = document.createElement("canvas")
    @transforms = []
    @currentTransform = new Rendering.Transform
    @context = @canvas.getContext("2d")
    @context.font = "16px Helvetica Neue"

  render: (bleed) =>
    @clear()

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

    @physics.bodies.forEach (body) =>
      @path => body.draw(this)

  isolate: (fn) ->
    @transforms.push(@currentTransform.clone())
    @context.save()
    fn()
    @context.restore()
    @currentTransform = @transforms.pop()

  clear: ->
    @isolate =>
      @_setTransform(Rendering.Transform.Identity)
      @context.clearRect(0, 0, @canvas.width, @canvas.height)

  path: (fn) ->
    @isolate =>
      @context.beginPath()
      fn()
      @context.closePath()

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
