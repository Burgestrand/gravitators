@Entities =
  Player: (entity) ->
    entity.addComponent "position", Components.Vector
    entity.addComponent "velocity", Components.Vector
    entity.addComponent "impulse",  Components.Vector
    entity.addComponent "rotation", Components.Number
    entity.addComponent "model",    Components.Polygon

  Bullet: (entity) ->
    entity.addComponent "position", Components.Vector
    entity.addComponent "velocity", Components.Vector
    entity.addComponent "model",    Components.Circle

  PlayerAControls: (entity) ->
    entity.addComponent "controls", Components.ShipControls,
      accelerate: "w"
      retardate: "s"
      left: "a"
      right: "d"

  PlayerBControls: (entity) ->
    entity.addComponent "controls", Components.ShipControls,
      accelerate: "up"
      retardate: "down"
      left: "left"
      right: "right"
