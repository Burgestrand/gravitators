class @Ship extends Physics.Body
  @attribute "shape", value: ->
    new Physics.Circle(radius: 8)
