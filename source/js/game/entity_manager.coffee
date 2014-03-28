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

  class ComponentContainer
    constructor: (@_template) ->
      for key, component of @_template
        @[key] = component.create()

    deallocate: ->
      for key, component in @_template
        component.release(@[key])

  constructor: (@repository = EntityManager) ->
    @id2info = this
    @ids = new IDList()

    allocator = ->
      {}
    initializer = (container, [id, @_template]) =>
      for key, component of @_template
        container[key] = component.create()
    deallocator = (container) ->
      for key, component of @_template
        component.release(container[key])
    @info = new SimplePool(allocator, initializer, deallocator)

  create: (typeName, fn = NoOp) ->
    id = @ids.create()
    info = @info.create(id, @repository[typeName])
    @id2info[id] = info
    fn(id, info)
    id

  release: (id) ->
    unless @id2info[id]
      throw new Error("entity #{id} does not exist")
    @ids.release(id)
    @info.release(@id2info[id])

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
