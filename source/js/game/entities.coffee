@Entities =
  Bullet:
    position: Components.Vector
    velocity: Components.Vector
    model:    Components.Circle
  Player:
    position: Components.Vector
    velocity: Components.Vector
    impulse:  Components.Vector
    rotation: Components.Number
    rotationSpeed: Components.Number
    model:    Components.Polygon
