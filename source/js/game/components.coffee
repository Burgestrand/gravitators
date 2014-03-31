vec2Allocator = ->
  vec2.create()
vec2Initializer = (obj, [x, y]) ->
  vec2.set(obj, x or 0, y or 0)

circleAllocator = ->
  { radius: null }
circleInitializer = (circle, [radius]) ->
  circle.radius = radius or 1

@Components =
  Vector: new SimplePool(vec2Allocator, vec2Initializer)
  Circle: new SimplePool(circleAllocator, circleInitializer)
