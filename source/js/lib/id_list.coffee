class @IDList
  constructor: ->
    @length = -1
    @ids = []
    @id2index = {}

    list = this
    count = 0
    allocator = ->
      count++
    initializer = ->
      id = @valueOf()
      list.length += 1
      list.id2index[id] = list.length
      list.ids[list.length] = id
    deallocator = (id) ->
      index = list.id2index[id]
      swap = list.ids[list.length]
      list.ids[list.length] = list.ids[index]
      list.ids[index] = swap
      list.id2index[swap] = index
      list.length -= 1

    @pool = new SimplePool(allocator, initializer, deallocator)

  create: ->
    @pool.create()

  release: (id) ->
    @pool.release(id)

  forEach: (fn) ->
    for index in [0..@length] by 1
      fn(@ids[index])
