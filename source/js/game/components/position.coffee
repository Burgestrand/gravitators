class Components.Position extends Component
  constructor: (x = 0, y = 0) ->
    @position or= vec2.create()
    vec2.set(@position, x, y)
