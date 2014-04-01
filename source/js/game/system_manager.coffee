class @SystemManager
  constructor: (@engine) ->
    @systems = {}
    @descriptors = []

  register: (name, system, options = {}) ->
    if @systems[name]
      throw new Error("system #{name} already registered!")
    @descriptors.push
      name: name
      update: system.update.bind(system)
      lag: 0
      timestep: (1000 / options.fps)
      maximumLag: (1000 / options.fps) * 10
    @systems[name] = system
    system.attached(@engine)

  deregister: (name) ->
    throw new Error("not yet implemented")

  update: (delta) ->
    for descriptor in @descriptors
      if descriptor.timestep
        descriptor.lag += delta

        if descriptor.lag > descriptor.maximumLag
          console.error "#{descriptor.name} is lagging!"
          descriptor.lag = descriptor.maximumLag

        while descriptor.lag >= descriptor.timestep
          descriptor.update(descriptor.timestep)
          descriptor.lag -= descriptor.timestep
      else
        descriptor.update(delta)
    undefined
