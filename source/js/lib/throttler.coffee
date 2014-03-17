class @Throttler
  constructor: (@delay) ->
    @_next = 0

  invoke: (fn) ->
    now = performance.now()
    if now >= @_next
      @_next = now + @delay
      fn()
