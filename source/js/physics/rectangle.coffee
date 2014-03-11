class @Physics.Rectangle extends Physics.Shape
  @attribute "width", value: -> 0
  @attribute "height", value: -> 0

  @property "size", get: ->
    new Vec2(@width, @height)
  @property "min", get: ->
    @position.sub(@size.divs(2))
  @property "max", get: ->
    @position.add(@size.divs(2))

  draw: ({ context }) ->
    context.rect(@min.x, @min.y, @width, @height)

    context.moveTo(@min.x, @min.y)
    context.arc(@min.x, @min.y, 1, 0, 2 * Math.PI, true)
    context.moveTo(@max.x, @max.y)
    context.arc(@max.x, @max.y, 1, 0, 2 * Math.PI, true)

    context.stroke()
