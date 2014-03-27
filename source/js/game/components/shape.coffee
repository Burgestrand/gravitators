#= require_self
#= require_directory ./shapes

class Components.Shape extends Component
  constructor: ->
    @shape or= new Components.Shape.Circle
    @shape.radius = 1
