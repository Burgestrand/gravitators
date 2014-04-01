class EntityManager.Entity
  parent = @
  child = ->
  child.prototype = parent.prototype
  allocator = ->
    new child
  initializer = (info, args) ->
    parent.apply(info, args)
  deallocator = (info) ->
    info.deallocate()
  pool = new SimplePool(allocator, initializer, deallocator)

  @create: ->
    pool.create.apply(pool, arguments)

  @release: (obj) ->
    pool.release(obj)

  count = 0
  constructor: ->
    @id or= "Entity-#{count++}"
    @components or= {}

  addComponent: (name, component) ->
    if @components[name] isnt undefined
      throw new Error("component #{name} already added!")
    @components[name] = component
    @[name] = component.create()

  removeComponent: (name) ->
    component = @components[name]
    component.release(@[name])
    @[name] = undefined
    @components[name] = undefined

  deallocate: ->
    for name, klass of @components when klass
      @removeComponent(name)
    undefined
