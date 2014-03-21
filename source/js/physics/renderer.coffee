class @Physics.Renderer
  constructor: (@physics) ->
    @canvas = document.createElement("canvas")
    @transforms = []
    @currentTransform = mat2d.create()
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
        vec2.squaredLength(p) - vec2.squaredLength(a)

      a = points[0]
      b = points[1]

      @path =>
        @context.strokeStyle = "magenta"
        @context.moveTo(a[0], a[1])
        @context.lineTo(b[0], b[1])
        @context.stroke()

        @context.moveTo(a[0], a[1])
        @context.arc(a[0], a[1], 3, 0, 2 * Math.PI, true)
        @context.moveTo(b[0], b[1])
        @context.arc(b[0], b[1], 3, 0, 2 * Math.PI, true)
        @context.stroke()

    @physics.actors.forEach ({ body }) =>
      @path =>
        @translate(body.position)
        body.draw(this)

  isolate: (fn) ->
    @transforms.push(mat2d.clone(@currentTransform))
    @context.save()
    fn()
    @context.restore()
    @currentTransform = @transforms.pop()

  clear: ->
    @isolate =>
      @setTransform(mat2d.identity(@currentTransform))
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
    @translate(vec2.fromValues(@canvas.width * 0.5, @canvas.height * 0.5))
    @scale(vec2.fromValues(1.0, -1))

  translate: (p) ->
    mat2d.translate(@currentTransform, @currentTransform, p)
    @setTransform(@currentTransform)

  scale: (p) ->
    mat2d.scale(@currentTransform, @currentTransform, p)
    @setTransform(@currentTransform)

  rotate: (r) ->
    mat2d.rotate(@currentTransform, @currentTransform, r)
    @setTransform(@currentTransform)

  setTransform: (matrix) ->
    @currentTransform = matrix
    [ scaleX, shearX, shearY, scaleY, translateX, translateY ] = matrix
    @context.setTransform(scaleX, shearX, shearY, scaleY, translateX, translateY)
