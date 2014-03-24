class @System
  constructor: ->

  setup: (@engine) ->

  update: (delta) ->

class @PhysicsSystem extends System
  update: (delta) ->
    @ticks += 1

class @RenderingSystem extends System
  constructor: (@width, @height) ->
    @canvas = document.createElement("canvas")
    @canvas.width = @width
    @canvas.height = @height

  draw: =>
    @ticks += 1
    @drawing = null

  update: (delta) ->
    @drawing or= requestAnimationFrame(@draw)
