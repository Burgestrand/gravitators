Array::findIndex ?= (callback, context) ->
  for element, index in this
    return index if callback(element, index, this)
