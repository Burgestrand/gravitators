class @Physics.Polygon extends Physics.Shape
  @attribute "points", value: -> []

  @property "BS", get: ->
    reducer = (maxSquared, point) ->
      lengthSquared = point.lengthSquared()
      if lengthSquared > maxSquared
        lengthSquared
      else
        maxSquared
    radius = Math.sqrt(@points.reduce(reducer, 0))
    new Physics.BoundingSphere(shape: this, radius: radius)

  draw: ({ context }) ->
    context.moveTo(@points[0].x, @points[0].y)
    @points[1..-1].forEach (point) ->
      context.lineTo(point.x, point.y)
    context.stroke()
