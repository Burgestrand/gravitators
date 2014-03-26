#= require_self
#= require_directory ./components

class @Component
  @create: ->
    pool = @pool()
    pool.create.apply(pool, arguments)

  @release: (obj) ->
    pool = @pool()
    pool.release(obj)

  @pool: ->
    unless @_poolOwner is this
      @_poolOwner = this
      constructor = this
      child = ->
      child.prototype = constructor.prototype
      allocator = ->
        obj = new child
        constructor.apply(obj, arguments)
        obj
      resettor  = ->
        constructor.apply(this, arguments)
      @_pool = new SimplePool(allocator, resettor)
    @_pool
