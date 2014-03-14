Object::clear = ->
  for own property of this
    delete @[property]
  this
