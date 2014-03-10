class Physics.Engine
  constructor: (@width, @height) ->
    @bounds = [new Plane2(1, 0, @width * 0.9),
               new Plane2(0, -1, @height * 0.9),
               new Plane2(-1, 0, @width * 0.9),
               new Plane2(0, 1, @height * 0.9)]
    @bodies = []

  tick: =>
