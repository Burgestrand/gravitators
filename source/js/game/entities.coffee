@Entities =
  Player: (entity) ->
    entity.addComponent "position", Components.Vector
    entity.addComponent "velocity", Components.Vector
    entity.addComponent "terminalVelocity", Components.Number
    entity.addComponent "impulse",  Components.Vector
    entity.addComponent "rotation", Components.Number
    entity.addComponent "gravity",  Components.Empty
    entity.addComponent "model",    Components.Polygon

    entity.terminalVelocity = 1.6

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
