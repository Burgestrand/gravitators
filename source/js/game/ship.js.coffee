class @Ship extends Movable
  @property "width"
  @property "height"
  @property "tip",
    get: ->
      vector = Point.vector(@height / 2, @rotation)
      @position.add(vector)

  @property "weapon"

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
    @gravity = new Point(0, 100)
    @maxVelocity = 300

  shoot: (timeElapsed) ->
    @weapon?.shoot(@)
