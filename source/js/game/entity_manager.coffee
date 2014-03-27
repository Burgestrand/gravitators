class @EntityManager
  @Bullet: [Component.ID, Component.Position, Component.Shape]

  constructor: (@engine) ->
    @ids = new IDList()
    @id2info = this
    @id2pool = {}
    @pools = {}

  pool: (type) ->
    @pools[type] or= do ->
      components = EntityManager[type]
      unless components
        throw new Error("unknown entity type: #{type}")
      allocator = -> {}
      initializer = (id) ->
        for component in components
          @[component.name] = component.create(id)
      deallocator = (obj) ->
        for component in components
          component.release(obj[component.name])
      new SimplePool(allocator, initializer, deallocator)

  create: (type) ->
    id = @ids.create()
    pool = @pool(type)
    @id2info[id] = pool.create(id)
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
      for component in components
        continue unless component of info
      results[id] = info
    results
