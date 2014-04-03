class Systems.Lifetime extends System
  update: ->
    for entity in @engine.entities.withComponents("ttl")
      entity.ttl -= 1
      @engine.entities.release(entity.id) if entity.ttl <= 0
