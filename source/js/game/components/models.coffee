class Shape
  constructor: ->
    @color = "black"
    @type = @constructor.name.toLowerCase()

class Circle extends Shape
  constructor: (@radius = 1) ->
    @boundingSphere = this
    super()

class Polygon extends Shape
  constructor: (@points = [-3, 0, -9, 9, 12, 0, -9, -9, -3, 0]) ->
    squaredRadius = 0
    vec2.forEach @points, null, null, null, (v) ->
      squaredLength = vec2.squaredLength(v)
      squaredRadius = squaredLength if squaredLength > squaredRadius
    @boundingSphere = Components.Circle.create(Math.sqrt(squaredRadius))
    super()

  deallocate: ->
    Components.Circle.release(@boundingSphere)

Components.Circle  = new ClassPool(Circle)
Components.Polygon = new ClassPool(Polygon)
