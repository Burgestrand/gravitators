class @Point extends Serenade.Model
  @property "x", "y"

  constructor: (@x, @y) ->

class @Vector extends Serenade.Model
  @property "length", value: 0
  @property "direction", value: 0
  @property "point"
    dependsOn: ["length", "direction"]
    get: ->
      d = Math.deg2rad(@direction)
      new Point(Math.cos(d) * @length, Math.sin(d) * @length)

  constructor: (@length, @direction) ->
