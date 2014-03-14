# [ scaleX     shearX     translateX ] = [ a b c ]
# [ shearY     scaleY     translateY ] = [ d e f ]
# [ 0          0          1          ] = [ g h i ]
class @Transform
  @Identity = new @({ scaleX: 1, scaleY: 1 })

  constructor: (matrix = Transform.Identity) ->
    @scaleX = matrix.scaleX ? 1
    @shearX = matrix.shearX ? 0
    @translateX = matrix.translateX ? 0

    @shearY = matrix.shearY ? 0
    @scaleY = matrix.scaleY ? 1
    @translateY = matrix.translateY ? 0

  translate: (v) ->
    @translateX += v.x * @scaleX + v.y * @shearX
    @translateY += v.x * @shearY + v.y * @scaleY
    this

  scale: (v) ->
    @scaleX *= v.x
    @shearX *= v.x
    @shearY *= v.y
    @scaleY *= v.y
    this

  rotate: (r) ->
    cos = Math.cos(r)
    sin = Math.sin(r)
    { scaleX, shearX, shearY, scaleY } = @
    @scaleX =  cos * scaleX + sin * shearX
    @shearX = -sin * scaleX + cos * shearX
    @shearY =  cos * shearY + sin * scaleY
    @scaleY = -sin * shearY + cos * scaleY
    this

  clone: ->
    new Transform(@)

  toString: ->
    widths = [@scaleX, @shearX, @translateX, @shearY, @scaleY, @translateY].map (n) ->
      ("" + n).length
    width = Math.max(widths...)
    pads = Array(width + 1).join(" ")
    pad = (num) -> (pads + num).slice(-width)

    """
    [ #{pad(@scaleX)} | #{pad(@shearX)} | #{pad(@translateX)} ]
    [ #{pad(@shearY)} | #{pad(@scaleY)} | #{pad(@translateY)} ]
    [ #{pad(0)} | #{pad(0)} | #{pad(1)} ]
    """
