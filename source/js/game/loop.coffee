class @Loop
  constructor: (@updatesPerSecond, @update, @render) ->
    @timestep = 1000 / @updatesPerSecond

  start: ->
    lag = 0
    previous = performance.now()
    update = =>
      now = performance.now()
      lag += now - previous
      previous = now
      while lag >= @timestep
        @update(@timestep)
        lag -= @timestep

    renderer = (now) =>
      delta = (performance.now() - previous) % @timestep
      bleed = delta / @timestep
      @render(bleed)
      requestAnimationFrame(renderer)

    @updater = setInterval(update, @timestep)
    @renderer = requestAnimationFrame(renderer)
    @running = true

  stop: ->
    clearInterval(@running)
    cancelAnimationFrame(@renderer)
    @running = false
