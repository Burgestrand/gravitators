class @Timing
  constructor: ->
    @timings = {}

  time: (name, fn) ->
    now = new Date()
    val = fn()
    res = new Date() - now
    @timings[name] = res
    val

  results: ->
    { name: name, time: time } for name, time of @timings
