CanvasRenderingContext2D::isolate = (fn) ->
  @save()
  fn()
  @restore()

CanvasRenderingContext2D::path = (fn) ->
  @isolate =>
    @beginPath()
    fn()
    @closePath()

CanvasRenderingContext2D::clear = ->
  @isolate =>
    @setTransform(1, 0, 0, 1, 0, 0) # identity matrix
    @clearRect(0, 0, @canvas.width, @canvas.height)

CanvasRenderingContext2D::point = ({ x, y }, color = "#000000") ->
  @path =>
    @fillStyle = color
    @arc(x, y, 3, 0, 2 * Math.PI, true)
    @stroke()
    @fill()

CanvasRenderingContext2D::vector = (v, o = new Vec2(0, 0), color = "red") ->
  @path =>
    @strokeStyle = color
    @moveTo(o.x, o.y)
    t = v.add(o)
    @lineTo(t.x, t.y)
    @stroke()

    @point(o, "black")
    @point(t, "white")

CanvasRenderingContext2D::plane = ({ n, d }, color = "#000000") ->
  @path =>
    @strokeStyle = color

    nr = n.rotate(Math.PI / 2)
    origin = Vec2.polar(n.angle() + Math.PI, d)
    from = origin.add(nr.muls(d))
    to = origin.add(nr.muls(-d))

    @moveTo(from.x, from.y)
    @lineTo(to.x, to.y)
    @stroke()

    @point(origin, "black")
    @point(from, "white")
    @point(to, "white")
