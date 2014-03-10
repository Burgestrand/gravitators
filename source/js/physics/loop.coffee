class @Loop
  constructor: (@update) ->

  start: (fps = 60) ->
    @stop()
    delta = (1000.0 / fps)
    next = performance.now() + delta
    prev = undefined
    tick = =>
      now = performance.now()
      if now >= next
        @update.call(@update, now - prev)
        prev = now
        next = now + delta
      @running = requestAnimationFrame(tick)
    tick()

  stop: ->
    cancelAnimationFrame(@running)
    @running = false
