cConstructor = c.Container
c.Container = ->
  container = new cConstructor()
  container.addChild(arguments...)
  container

Object.values = (object) ->
  object[key] for key in Object.keys(object)

Math.deg2rad = (degrees) ->
  degrees * (Math.PI / 180)

Math.rad2deg = (radians) ->
  radians * (180 / Math.PI)

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
