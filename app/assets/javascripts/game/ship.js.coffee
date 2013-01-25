class @Ship extends Serenade.Model
  @property "shape"
  @property "width"
  @property "height"

  @property "position"
    dependsOn: [ "x", "y" ]
    get: ->
      new Point(@x, @y)
    set: (point) ->
      { @x, @y } = point

  @delegate "x", "y", "rotation", to: "shape"

  constructor: (@width, @height, color) ->
    @shape = new c.Shape()
    @shape.regX = @height / 2
    @shape.regY = @width / 2
    @shape.graphics
      .setStrokeStyle(2, "round", "miter", 1)
      .beginStroke("#000000")
      .beginFill(color)
      .moveTo(0, 0)
      .lineTo(@height, @width / 2)
      .lineTo(0, @width)
      .lineTo(@height * 0.3, @width / 2)
      .closePath()
      .endFill()
      .endStroke()
