class Components.Position extends Component
  constructor: ->
    @position or= vec2.create()
    vec2.clear(@position)
