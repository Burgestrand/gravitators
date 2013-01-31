class @Ship extends Movable
  @property "width"
  @property "height"
  @property "weapon"
  @property "tip"
    get: ->
      vector = Point.vector(@height, @rotation)
      @position.add(vector)

  constructor: (@width, @height, color) ->
    @shape = new c.Shape()
    @shape.regX = @height / 2
    @shape.regY = @width / 2
    @shape.graphics
      .setStrokeStyle(2, "round")
      .beginStroke("#000000")
      .beginFill(color)
      .moveTo(0, 0)
      .lineTo(@height, @width / 2)
      .lineTo(0, @width)
      .lineTo(@height * 0.3, @width / 2)
      .closePath()
      .endFill()
      .endStroke()

  shoot: (timeElapsed) ->
    @weapon?.shoot(@tip, @rotation)
