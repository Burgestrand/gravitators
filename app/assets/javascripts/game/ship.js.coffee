class @Ship extends Movable
  @property "width"
  @property "height"
  @property "tip"
    get: ->
      vector = Point.vector(@height / 2, @rotation)
      @position.add(vector)

  @property "weapon"

  @property "acceleration", value: 200
  @property "retardation", value: 300

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

  accelerate: (timeElapsed) ->
    @velocity += timeElapsed * (@acceleration / 1000)

  retardate: (timeElapsed) ->
    @velocity -= timeElapsed * (@retardation / 1000)

  shoot: (timeElapsed) ->
    @weapon?.shoot(@)
