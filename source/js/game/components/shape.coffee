#= require_self
#= require_directory ./shapes

class Component.Shape extends Component
  constructor: (radius = 1) ->
    @shape = new Component.Shape.Circle(radius)
