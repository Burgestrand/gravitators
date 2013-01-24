class @Ship extends Serenade.Model
  @delegate "x", "y", to: "shape"

  constructor: ->
    @shape = new c.Shape()

    height = 30
    width  = 24
    @shape.graphics
      .beginFill("#cc0000")
      .moveTo(0, height)
      .lineTo(width / 2, 0)
      .lineTo(width, height)
      .lineTo(width / 2, height * 0.7)
      .closePath()
