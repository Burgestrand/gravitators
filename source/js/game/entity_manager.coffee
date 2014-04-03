#= require_self
#= require_directory ./entity_manager

class @EntityManager
  NoOp = ->

  constructor: ->
    @id2entity = this
    @id2index = {}
    @entities = this
    @length = 0

  create: ->
    entity = EntityManager.Entity.create()
    @id2entity[entity.id] = entity

    @id2index[entity.id] = @length
    @entities[@length] = entity.id
    @length += 1

    for fn in arguments
      fn(entity)

    entity.id

  release: (id) ->
    if @id2entity[id] is undefined
      throw new Error("entity #{id} does not exist")

    EntityManager.Entity.release(@id2entity[id])
    @id2entity[id] = undefined

    @length -= 1
    index = @id2index[id]
    otherID = @[@length]
    @[@length] = @[index]
    @[index] = otherID
    @id2index[otherID] = index
    @id2index[id] = @length

  withComponents: ->
    results = []
    for id in @entities
      entity = @id2entity[id]
      if entity.hasComponents(arguments)
        results.push(entity)
    results
