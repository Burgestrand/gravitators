class Systems.Lifetime extends System
  update: ->
    for id, entity of @engine.entities.withComponents("ttl")
      entity.ttl -= 1
      @engine.entities.release(id) if entity.ttl <= 0
