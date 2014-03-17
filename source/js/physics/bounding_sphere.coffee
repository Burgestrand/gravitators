class @Physics.BoundingSphere extends GameObject
  @attribute "radius", value: -> 0
  @attribute "shape"
  @delegate "position", to: "shape"
