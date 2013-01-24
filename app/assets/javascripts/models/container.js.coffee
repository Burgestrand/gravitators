class @Container extends Serenade.Model
  @collection "children"

  @property "shapes"
    dependsOn: "children:shape"
    get: -> @children.map((c) -> c.shape)

  constructor: ->
    super
    @container = new c.Container()
    @shapes_property.bind =>
      @container.removeAllChildren()
      @container.addChild(@shapes...)

  push: ->
    @children.push(arguments...)
