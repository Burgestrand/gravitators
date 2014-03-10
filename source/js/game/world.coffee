class @World
  constructor: (@width, @height) ->
    @gameLoop = new Loop(@tick.bind(@), @render.bind(@))
    @gameLoop.start(60)

    @bounds = [new Plane2(1, 0, @width * 0.25),
               new Plane2(0, -1, @height * 0.25),
               new Plane2(-1, 0, @width * 0.25),
               new Plane2(0, 1, @height * 0.25)]

    @entities = []

  tick: ->

  render: ->
