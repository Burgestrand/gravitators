class @IDList
  constructor: ->
    @length = 0
    @id2index = {}

    list = this
    count = 0
    allocator = ->
      "#{count++}"
    initializer = ->
      id = @valueOf()
      list.id2index[id] = list.length
      list[list.length] = id
      list.length += 1
    deallocator = (id) ->
      list.length -= 1
      index = list.id2index[id]
      swap = list[list.length]
      list[list.length] = list[index]
      list[index] = swap
      list.id2index[swap] = index

    @pool = new SimplePool(allocator, initializer, deallocator)

  create: ->
    @pool.create()

  release: (id) ->
    @pool.release(id)
