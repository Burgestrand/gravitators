class @World
  constructor: (@width, @height) ->
    @gameLoop = new Loop(@tick.bind(@), @render.bind(@))
    @gameLoop.start(60)

  tick: ->

  render: ->
