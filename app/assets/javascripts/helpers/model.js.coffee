def = Object.defineProperty

class @Model
  @property: (names..., options = {}) ->
    if typeof(options) is "string"
      names.push(options)
      options = {}

    options.configurable ||= true
    options.enumerable   ||= true
    if !(options.get? or options.set?)
      options.writable = true

    names.forEach (name) =>
      def @prototype, name, options

  @forward: (names..., options = {}) ->
    to = options.to
    names.forEach (name) =>
      @property name,
        get: -> @[to]?[name]
        set: (value) -> @[to]?[name] = value
