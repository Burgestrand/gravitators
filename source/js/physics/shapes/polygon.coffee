class @Physics.Polygon extends Physics.Shape
  @attribute "points", value: -> []

  @property "BS", get: ->
    reducer = (maxSquared, point) ->
      squaredLength = vec2.squaredLength(point)
      if squaredLength > maxSquared
        squaredLength
      else
        maxSquared
    radius = Math.sqrt(@points.reduce(reducer, 0))
    new Physics.BoundingSphere(shape: this, radius: radius)

  draw: ({ context }) ->
    context.moveTo(@points[0][0], @points[0][1])
    @points[1..-1].forEach (point) ->
      context.lineTo(point[0], point[1])
    context.stroke()
