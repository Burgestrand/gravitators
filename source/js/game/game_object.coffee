class @GameObject
  @attribute: (name, options = {}) ->
    unless @hasOwnProperty("attributes")
      @attributes = if @attributes
        Object.create(@attributes)
      else
        {}
    @attributes[name] = options

    prop = "_#{name}"
    get = options.get ? -> @[prop]
    set = options.set ? (v) -> @[prop] = v
    @property(name, { get, set })

  @delegate: (name, options = {}) ->
    unless @hasOwnProperty("delegates")
      @delegates = if @delegates
        Object.create(@delegates)
      else
        {}
    @delegates[name] = options

    get = -> @[options.to]?[name]
    set = (v) -> @[options.to][name] = v
    @property(name, { get, set })

  @property: (name, options = {}) ->
    options.get ?= -> throw new Error("get #{name} is not implemented")
    options.set ?= -> throw new Error("get #{name} is not implemented")
    Object.defineProperty(@prototype, name, options)

  constructor: (attributes = {}) ->
    for name, options of @constructor.attributes
      @[name] = attributes[name] ? options.value?.call(this)
      delete attributes[name]

    for own name, value of attributes when name of @constructor.delegates
      @[name] = value
      delete attributes[name]

    extras = Object.getOwnPropertyNames(attributes)
    if extras.length
      throw new Error("unknown #{@constructor.name} attributes #{extras.join(", ")}")
