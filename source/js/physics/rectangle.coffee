class @Physics.Rectangle extends Physics.Shape
  @attribute "width", value: -> 0
  @attribute "height", value: -> 0

  @property "size", get: ->
    new Vec2(@width, @height)
  @property "min", get: ->
    @position.sub(@size.divs(2))

  @property "BS", get: ->
    position = @position
    radius = Math.max(@width, @height) / 2
    new Physics.Circle({ position, radius })

  draw: ({ context }) ->
    context.rect(@min.x, @min.y, @width, @height)
    context.stroke()
