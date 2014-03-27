#= require_self
#= require_directory ./shapes

class Components.Shape extends Component
  constructor: (radius = 1) ->
    @shape = new Components.Shape.Circle(radius)
