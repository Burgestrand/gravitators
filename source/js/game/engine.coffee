#= require_self
#= require ./components
#= require ./entities
#= require ./entity_manager
#= require ./systems
#= require ./system_manager
#= require ./loop

class @Engine
  constructor: ->
    @entities = new EntityManager(Entities)
    @systemManager = new SystemManager(this)
    @systems = @systemManager.systems
    @loop = new Loop(@update.bind(this))

  start: ->
    @loop.start()
    @running = true

  stop: ->
    @loop.stop()
    @running = false

  attach: (name, system, options = {}) ->
    @systemManager.register(name, system, options)

  update: (delta) ->
    @systemManager.update(delta)
