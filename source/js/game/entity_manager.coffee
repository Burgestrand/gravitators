class @EntityManager
  NoOp = ->

  class IDList
    constructor: ->
      @length = 0
      id2index = {}
      count = 0
      allocator = ->
        "#{count++}"
      initializer = (id) =>
        id2index[id] = @length
        @[@length] = id
        @length += 1
      deallocator = (id) =>
        @length -= 1
        index = id2index[id]
        swap = @[@length]
        @[@length] = @[index]
        @[index] = swap
        id2index[swap] = index
      @pool = new SimplePool(allocator, initializer, deallocator)

    create: ->
      @pool.create()

    release: (id) ->
      @pool.release(id)

  constructor: (@repository = EntityManager) ->
    @id2info = this
    @ids = new IDList()

    allocator = ->
      {}
    initializer = (container, [template]) =>
      container._template = template
      for key, component of template
        container[key] = component.create()
    deallocator = (container) ->
      for key, component of container._template
        component.release(container[key])
    @info = new SimplePool(allocator, initializer, deallocator)

  create: (typeName, fn = NoOp) ->
    unless @repository[typeName]
      throw new Error("unknown entity type: #{typeName}")
    id = @ids.create()
    info = @info.create(@repository[typeName])
    @id2info[id] = info
    fn(id, info)
    id

  release: (id) ->
    unless @id2info[id]
      throw new Error("entity #{id} does not exist")
    @ids.release(id)
    @info.release(@id2info[id])
    @id2info[id] = null

  find: (id) ->
    @id2info[id]

  withComponents: ->
    results = {}
    for id in @ids
      info = @id2info[id]
      broke = false
      for component in arguments
        unless component of info
          broke = true
          break
      results[id] = info unless broke
    results
