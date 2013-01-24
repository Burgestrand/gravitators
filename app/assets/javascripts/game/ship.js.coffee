class Ship extends Serenade.Model
  @property "shape"

  @property "width"
  @property "height"

  constructor: (@width, @height) ->
    @shape = new c.Shape()
    @shape.regX = @width / 2
    @shape.regY = @height / 2
    @shape.graphics
      .setStrokeStyle(2, "round", "miter", 1)
      .beginStroke("#000000")
      .beginFill("#cc0000")
      .moveTo(0, @height)
      .lineTo(@width / 2, 0)
      .lineTo(@width, @height)
      .lineTo(@width / 2, @height * 0.7)
      .closePath()

class @Player extends Serenade.Model
  @property "ship"
  @property "position"
    get: ->
      new c.Point(@x, @y)
    set: (point) ->
      { @x, @y } = point

  @delegate "shape", to: "ship"
  @delegate "x", "y", "rotation", to: "shape"

  constructor: (speed, left, right, shoot) ->
    @ship = new Ship(24, 30)
