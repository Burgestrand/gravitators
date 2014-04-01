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

Components.Circle  = new SimplePool(circleAllocator, circleInitializer)
Components.Polygon = new SimplePool(polygonAllocator, polygonInitializer)
