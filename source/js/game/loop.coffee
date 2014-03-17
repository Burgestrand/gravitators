class @Loop
  constructor: (@update, @render) ->

  countFPS: (active) ->
    if active and not @_update
      @_update = @update
      ticks = 0
      @update = =>
        ticks += 1
        @_update.apply(@_update, arguments)
      sampleFPS = =>
        @fps = ticks
        ticks = 0
      @_fpsCounter = setInterval(sampleFPS, 1000)
    else if not active
      @update = @_update
      clearInterval(@_fpsCounter)
      delete @_fpsCounter
      delete @_update
      delete @fps

  start: (fps = 60) ->
    @stop()
    delta = 1000 / fps
    clamp = delta * 10
    diff = 0
    previous = performance.now()
    tick = (now) =>
      diff += now - previous
      previous = now

      # in case physics is slower than FPS, we avoid
      # the loop coming to a halt by going slower
      if diff > clamp
        diff = clamp

      # tick the physics forward by a deterministic time value
      while diff > delta
        @update(fps, delta)
        diff -= delta

      # trigger a rendering with information of how far we are
      # into the next frame
      @render(diff / delta)
      @running = requestAnimationFrame(tick)
    @running = requestAnimationFrame(tick)

  stop: ->
    cancelAnimationFrame(@running)
    @running = false
