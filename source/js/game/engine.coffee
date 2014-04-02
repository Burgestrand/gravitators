#= require_self
#= require ./components
#= require ./entities
#= require ./entity_manager
#= require ./systems
#= require ./canvas_renderer
#= require ./loop

class @Engine
  constructor: ->
    @entities = new EntityManager
    @systems = {}
    @systemsOrder = []
    @loop = new Loop(updatesPerSecond = 100, @update.bind(this), @render.bind(this))

  start: ->
    @loop.start()
    @running = true

  stop: ->
    @loop.stop()
    @running = false

  attach: (name, system) ->
    if @systems[name]
      throw new Error("system #{name} already registered!")
    @systemsOrder.push(system.update.bind(system))
    @systems[name] = system
    system.attached(this)

  update: (delta) ->
    update() for update in @systemsOrder
    undefined

  render: (delta) ->
    @renderer?.update(delta)
