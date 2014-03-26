class @EntityManager
  @Bullet: [Component.ID, Component.Position, Component.Shape]

  constructor: (@engine) ->
    @ids = new IDList()
    @id2info = this
    @id2pool = {}
    @pools = {}

  pool: (type) ->
    @pools[type] or= do ->
      allocator = -> {}
      initializer = (id) ->
        for component in EntityManager[type]
          @[component.name] = component.create(id)
      deallocator = (obj) ->
        for component in EntityManager[type]
          component.release(obj[component.name])
      new SimplePool(allocator, initializer, deallocator)

  create: (type) ->
    id = @ids.create()
    pool = @pool(type)
    @id2info[id] = pool.create()
    @id2pool[id] = pool
    id

  destroy: (id) ->
    unless @id2components[id]
      throw new Error("entity #{id} does not exist")
    pool = @id2pool[id]
    info = @id2info[id]
    pool.release(info)
    @id2pool[id] = null
    @id2info[id] = null

  find: (id) ->
    @id2info[id]

  withComponents: (components) ->
    id2info  = @id2info
    results  = {}
    searcher = (id) ->
      info = id2info[id]
      for component in components
        return unless component of info
      results[id] = info
    @ids.forEach(searcher)
    results
