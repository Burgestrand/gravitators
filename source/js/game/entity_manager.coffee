#= require_self

class @EntityManager
  constructor: ->
    @ids = []

  create: (entityName, options = {}) ->
    id = @id()

    descriptor = {}
    for component in Entities[entityName]
      descriptor[component.name] = new component(id)
    Object.freeze(descriptor)

    @[id] = descriptor
    id

  entitiesWith: (componentNames) ->
    results = {}
    for id in @ids
      descriptor = @[id]
      matches = true
      for name in componentNames
        matches = matches && (name of descriptor)
      results[id] = descriptor if matches
    results

  destroy: (id) ->
    # TODO: this is bad for cache!
    delete @[id]

  id: ->
    id = @ids.length
    @ids.push(id)
    id

@Entities = {
  "Bullet": [Component.ID, Component.Position, Component.Renderable]
}
