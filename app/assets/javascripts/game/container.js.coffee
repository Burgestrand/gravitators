class @Container extends Serenade.Model
  @collection "children"

  @property "shapes"
    dependsOn: "children:shape"
    get: -> @children.map((c) -> c.shape)

  constructor: ->
    @shape = new c.Container()
    @shapes_property.bind =>
      @shape.removeAllChildren()
      @shape.addChild(@shapes...)
    @children.update(arguments)

  [ "push", "update", "forEach", "filter" ].forEach (fn) =>
    @::[fn] = ->
      @children[fn](arguments...)
