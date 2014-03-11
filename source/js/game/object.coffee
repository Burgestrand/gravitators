class @GameObject
  @attribute: (name, options = {}) ->
    unless @hasOwnProperty("attributes")
      @attributes = if @attributes
        Object.create(@attributes)
      else
        {}
    @attributes[name] = options

    prop = "_#{name}"
    getter = options.get ? -> @[prop]
    setter = options.set ? (v) -> @[prop] = v
    Object.defineProperty(@prototype, name, get: getter, set: setter)

  @delegate: (name, options = {}) ->
    getter = -> @[options.to]?[name]
    setter = (v) -> @[options.to][name] = v
    Object.defineProperty(@prototype, name, get: getter, set: setter)

  constructor: (attributes = {}) ->
    for name, options of @constructor.attributes
      @[name] = attributes[name] ? options.value?.call(this)
      delete attributes[name]

    extras = Object.getOwnPropertyNames(attributes)
    if extras.length
      throw new Error("unknown #{@constructor.name} attributes #{extras.join(", ")}")
