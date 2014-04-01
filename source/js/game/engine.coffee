#= require_self
#= require ./components
#= require ./entities
#= require ./entity_manager
#= require ./system
#= require ./loop

class @Engine
  constructor: ->
    @entities = new EntityManager(Entities)
    @systems = {}
    @_systems = []
    @loop = new Loop(@update)

  register: (name, system, options = {}) ->
    descriptor =
      name: name
      system: system
      fps: options.fps
      lag: 0
      timestep: (1000 / options.fps)
      maximumLag: (1000 / options.fps) * 10
    if @systems.hasOwnProperty(name)
      throw new Error("system #{name} already registered!")
    @systems[name] = system
    @_systems.push(descriptor)
    system.setup(this)
    system

  start: ->
    @loop.start()
    @running = true

  stop: ->
    @loop.stop()

  update: (diff) =>
    for descriptor in @_systems
      if descriptor.fps
        descriptor.lag += diff

        if descriptor.lag > descriptor.maximumLag
          console.error "#{descriptor.name} is lagging!"
          descriptor.lag = descriptor.maximumLag

        while descriptor.lag >= descriptor.timestep
          descriptor.system.update(descriptor.timestep, this)
          descriptor.lag -= descriptor.timestep
      else
        descriptor.system.update(diff, this)
