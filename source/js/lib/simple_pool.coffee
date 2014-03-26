class @SimplePool
  NoOp = ->

  constructor: (@allocator, @initializer = NoOp, @deallocator = NoOp) ->
    @length = 0
    @free = []

  create: ->
    free = if @length
      @free[--@length]
    else
      @allocator()
    @initializer.apply(free, arguments)
    free

  release: (obj) ->
    @deallocator(obj)
    @free[@length++] = obj
