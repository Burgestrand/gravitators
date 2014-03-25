#= require_self
#= require_directory ./shapes

class Component.Shape extends Component
  constructor: ->
    radius = Math.floor(Math.random() * 5 + 1)
    @shape = new Component.Shape.Circle(radius)
