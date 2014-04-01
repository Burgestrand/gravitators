@Entities =
  Player: (entity) ->
    entity.addComponent("position", Components.Vector)
    entity.addComponent("velocity", Components.Vector)
    entity.addComponent("impulse",  Components.Vector)
    entity.addComponent("rotation", Components.Number)
    entity.addComponent("rotationSpeed", Components.Number)
    entity.addComponent("model",    Components.Polygon)

  Bullet: (entity) ->
    entity.addComponent("position", Components.Vector)
    entity.addComponent("velocity", Components.Vector)
    entity.addComponent("model",    Components.Circle)
