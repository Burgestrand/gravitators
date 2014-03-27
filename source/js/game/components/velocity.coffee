class Components.Velocity extends Component
  constructor: ->
    @velocity or= vec2.create()
    @force or= vec2.create()
    vec2.clear(@velocity)
    vec2.clear(@force)
