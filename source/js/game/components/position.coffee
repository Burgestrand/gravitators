class Component.Position extends Component
  constructor: ->
    s = 640
    x = Math.floor((Math.random() * s) - (s / 2))
    y = Math.floor((Math.random() * s) - (s / 2))
    @position = vec2.fromValues(x, y)
