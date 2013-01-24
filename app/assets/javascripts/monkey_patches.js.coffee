round = Math.round
Math.round = (value, decimals = 0) ->
  factor = Math.pow(10, decimals)
  round(value * factor) / factor

Number::lpad = (n, x = "0") ->
  (Array(n).join(x) + this)[-n..]

Node::insertAfter = (node, newNode) ->
  if node.parentNode isnt this
    throw new Error("node’s parent is not myself!")
  @insertBefore(newNode, node.nextSibling)
