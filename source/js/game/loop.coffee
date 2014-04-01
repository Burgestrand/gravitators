class @Loop
  constructor: (@update) ->
    @fps = 60

  start: (fps = @fps) ->
    @fps = fps
    delta = 0
    previous = performance.now()
    update = =>
      now = performance.now()
      delta = now - previous
      previous = now
      @update(delta)
    @running = setInterval(update, 1000 / fps)

  stop: ->
    clearInterval(@running)
    @running = false
