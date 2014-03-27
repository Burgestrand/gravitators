class @EntityManager
  @Bullet: [Components.ID, Components.Position, Components.Shape]

  constructor: (@repository = EntityManager) ->
    @ids = new IDList()
    @id2info = this
    @id2pool = {}
    @pools = {}

  pool: (type) ->
    unless @pools[type]
      components = @repository[type]
      unless components
        throw new Error("unknown entity type: #{type}")
      allocator = -> {}
      initializer = ->
        for component in components
          @[component.name] = component.create()
      deallocator = (obj) ->
        for component in components
          component.release(obj[component.name])
      @pools[type] = new SimplePool(allocator, initializer, deallocator)
    @pools[type]

  create: (type) ->
    id = @ids.create()
    pool = @pool(type)
    @id2info[id] = pool.create()
    @id2pool[id] = pool
    id

  release: (id) ->
    unless @id2info[id]
      throw new Error("entity #{id} does not exist")
    @ids.release(id)
    pool = @id2pool[id]
    info = @id2info[id]
    pool.release(info)
    @id2pool[id] = null
    @id2info[id] = null

  find: (id) ->
    @id2info[id]

  withComponents: (components) ->
    results = {}
    for id in @ids
      info = @id2info[id]
      broke = false
      for component in components
        unless component.name of info
          broke = true
          break
      results[id] = info unless broke
    results
