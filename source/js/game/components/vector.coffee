allocator = ->
  vec2.create()
initializer = (obj, [x, y]) ->
  vec2.set(obj, x or 0, y or 0)

Components.Vector = new SimplePool(allocator, initializer)
