class @Physics.Renderer
  constructor: (@physics) ->
    @canvas = document.createElement("canvas")
    @transforms = []
    @currentTransform = new Transform
    @context = @canvas.getContext("2d")
    @context.font = "16px Helvetica Neue"

  render: (bleed) =>
    @clear()

    @path =>
      @context.arc(0, 0, 3, 0, 2 * Math.PI, true)
      @context.stroke()

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
        @context.strokeStyle = "magenta"
        @context.moveTo(a.x, a.y)
        @context.lineTo(b.x, b.y)
        @context.stroke()

        @context.moveTo(a.x, a.y)
        @context.arc(a.x, a.y, 3, 0, 2 * Math.PI, true)
        @context.moveTo(b.x, b.y)
        @context.arc(b.x, b.y, 3, 0, 2 * Math.PI, true)
        @context.stroke()

    @physics.actors.forEach ({ body }) =>
      @path =>
        @translate(body.position)
        body.draw(this)

  isolate: (fn) ->
    @transforms.push(@currentTransform.clone())
    @context.save()
    fn()
    @context.restore()
    @currentTransform = @transforms.pop()

  clear: ->
    @isolate =>
      @setTransform(Transform.Identity)
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
    @translate({ x: @canvas.width * 0.5, y: @canvas.height * 0.5 })
    @scale(x: 1.0, y: -1)

  translate: (p) ->
    @currentTransform.translate(p)
    @setTransform(@currentTransform)

  scale: (p) ->
    @currentTransform.scale(p)
    @setTransform(@currentTransform)

  rotate: (r) ->
    @currentTransform.rotate(r)
    @setTransform(@currentTransform)

  setTransform: (matrix) ->
    @currentTransform = matrix
    @context.setTransform(matrix.scaleX, matrix.shearX, matrix.shearY, matrix.scaleY, matrix.translateX, matrix.translateY)
