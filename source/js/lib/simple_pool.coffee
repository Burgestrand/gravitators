class @SimplePool
  constructor: (@allocator, @resettor) ->
    @length = 0
    @free = []

  create: ->
    if @length
      free = @free[--@length]
      @resettor.apply(free, arguments)
      free
    else
      @allocator.apply(null, arguments)

  release: (obj) ->
    @free[@length++] = obj
