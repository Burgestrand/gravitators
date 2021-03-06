vec2.polar = (angle, length) ->
  x = Math.cos(angle) * length
  y = Math.sin(angle) * length
  vec2.fromValues(x, y)

vec2.fromValue = (xy) ->
  vec2.fromValues(xy, xy)
