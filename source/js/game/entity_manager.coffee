#= require_self

class @EntityManager
  constructor: (@engine) ->
    @ids = new ResourcePool

  create: (entityName) ->
    id = @ids.create()

    components = {}
    for component in Entities[entityName]
      components[component.name] = new component(@engine, id)
    Object.freeze(components)

    @[id] = components
    id

  destroy: (id) ->
    unless @ids.release(id)
      throw new Error("entity #{id} does not exist")
    @[id] = null

  withComponents: (componentNames) ->
    self = @
    results = {}
    @ids.forEach (id) ->
      components = self[id]
      matches = true
      for name in componentNames
        matches = matches && (name of components)
      results[id] = components if matches
    results

@Entities = {
  "Bullet": [Component.ID, Component.Position, Component.Shape]
}
