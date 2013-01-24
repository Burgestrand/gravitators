class @Container extends Serenade.Collection
  constructor: ->
    super
    @container = new c.Container()
    @change.bind (me) =>
      @container.removeAllChildren()
      @container.addChild(@map((c) -> c.shape)...)
