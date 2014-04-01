class @Loop
  constructor: (@update) ->
    @fps = 60

  start: (fps = @fps) ->
    @fps = fps
    diff = 0
    previous = performance.now()
    update = =>
      now = performance.now()
      diff = now - previous
      previous = now
      @update(diff)
    @running = setInterval(update, 1000 / fps)

  stop: ->
    clearInterval(@running)
    @running = false
