#= require_self

class @EntityManager
  constructor: ->
    @ids = new ResourcePool

  create: (entityName) ->
    id = @ids.create()

    components = {}
    for component in Entities[entityName]
      components[component.name] = new component(id)
    Object.freeze(components)

    @[id] = components
    id

  destroy: (id) ->
    @ids.release(id)
    @[id] = null

  withComponents: (componentNames) ->
    entities = @
    results = {}
    @ids.forEach (id) ->
      components = entities[id]
      matches = true
      for name in componentNames
        matches = matches && (name of components)
      results[id] = components if matches
    results

@Entities = {
  "Bullet": [Component.ID, Component.Position, Component.Renderable]
}
