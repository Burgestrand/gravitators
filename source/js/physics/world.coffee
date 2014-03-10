class @World
  constructor: (@width, @height) ->
    @gameLoop = new Loop(@tick.bind(@))
    @gameLoop.start(2)

  tick: ->
