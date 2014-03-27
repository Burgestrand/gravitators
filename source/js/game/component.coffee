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
        new child
      initializer = ->
        constructor.apply(this, arguments)
      deallocator = (obj) ->
        obj.deallocate()
      @_pool = new SimplePool(allocator, initializer, deallocator)
    @_pool

  deallocate: ->
    # no op

@Components = {}
