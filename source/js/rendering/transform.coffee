# [ scaleX     shearY     0 ]
# [ shearX     scaleY     0 ]
# [ translateX translateY 1 ]
class @Transform
  @Identity = new @({ scaleX: 1, scaleY: 1 })

  constructor: (matrix = Transform.Identity) ->
    @scaleX = matrix.scaleX ? 1
    @shearX = matrix.shearX ? 0
    @shearY = matrix.shearY ? 0
    @scaleY = matrix.scaleY ? 1
    @translateX = matrix.translateX ? 0
    @translateY = matrix.translateY ? 0

  clone: ->
    new Transform(@)

  toString: ->
    widths = [@scaleX, @shearX, @shearY, @scaleY, @translateX, @translateY].map (n) ->
      ("" + n).length
    width = Math.max(widths...)
    pads = Array(width + 1).join(" ")
    pad = (num) -> (pads + num).slice(-width)

    """
    [ #{pad(@scaleX)} | #{pad(@shearY)} | #{pad(0)} ]
    [ #{pad(@shearX)} | #{pad(@scaleY)} | #{pad(0)} ]
    [ #{pad(@translateX)} | #{pad(@translateY)} | #{pad(1)} ]
    """
