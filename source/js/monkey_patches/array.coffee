Array::findIndex ?= (callback, context = callback) ->
  for element, index in this
    return index if callback.call(context, element, index, this)

Array::find ?= (callback, context = callback) ->
  @[@findIndex(callback, context)]

Array::findAll ?= (callback, context = callback) ->
  reducer = (results, element, index) ->
    if callback.call(context, element, index, this)
      results.concat(element)
    else
      results

  @reduce(reducer, [])
