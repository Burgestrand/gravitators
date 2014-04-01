vec2Allocator = ->
  vec2.create()
vec2Initializer = (obj, [x, y]) ->
  vec2.set(obj, x or 0, y or 0)

createModel = (type) ->
  { type: type, color: "black" }

circleAllocator = ->
  createModel("circle")
circleInitializer = (model, [radius]) ->
  model.radius = radius or 1

ship = [-3, 0, -9, 9, 12, 0, -9, -9, -3, 0]
polygonAllocator = ->
  createModel("polygon")
polygonInitializer = (model) ->
  model.points = ship

@Components =
  Vector: new SimplePool(vec2Allocator, vec2Initializer)
  Circle: new SimplePool(circleAllocator, circleInitializer)
  Polygon: new SimplePool(polygonAllocator, polygonInitializer)
  Player: "A"
  Number: 0
