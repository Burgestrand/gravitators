#= require_self
#= require ./game/component
#= require ./game/entity_manager
#= require ./game/system

class @Game
  constructor: ->
    @entities = new EntityManager(this)
    @systems = {}
    @_systems = []

  register: (system, options = {}) ->
    name = system.constructor.name
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

  update: (delta) ->

  start: (maxFPS = 120) ->
    diff = 0
    previous = performance.now()
    update = =>
      now = performance.now()
      diff = now - previous
      previous = now

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

    @running = setInterval(update, 1000 / maxFPS)

  stop: ->
    clearInterval(@running)
    @running = false
