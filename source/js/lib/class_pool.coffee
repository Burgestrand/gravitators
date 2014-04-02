@ClassPool = (klass) ->
  child = ->
  child.prototype = Object.create(klass.prototype)
  child.prototype.deallocate ?= (->)
  allocator = ->
    new child
  initializer = (object, args) ->
    klass.apply(object, args)
  deallocator = (object) ->
    object.deallocate()
  new SimplePool(allocator, initializer, deallocator)
