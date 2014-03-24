#= require_self
#= require ./game/component
#= require ./game/entity_manager
#= require ./game/system

class @Game
  constructor: ->
    @entities = new EntityManager()
    @systems = []

  register: (system, options = {}) ->
    descriptor =
      name: system.constructor.name
      system: system
      fps: options.fps
      lag: 0
      timestep: (1000 / options.fps)
      maximumLag: (1000 / options.fps) * 10
    @systems.push(descriptor)
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

      for descriptor in @systems
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
