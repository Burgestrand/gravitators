class Rendering.Renderer
  constructor: (@canvas = document.createElement("canvas")) ->
    @currentTransform = new Rendering.Transform
    @context = @canvas.getContext("2d")
    @context.font = "16px Helvetica Neue"

  resize: ->
    @canvas.width = @canvas.offsetWidth
    @canvas.height = @canvas.offsetHeight

    # center the origin
    @_transform (matrix) ->
      matrix.translateX = @canvas.width * 0.5
      matrix.translateY = @canvas.height * 0.5

  _transform: (fn) ->
    fn.call(@, @currentTransform) if fn
    matrix = @currentTransform
    @context.setTransform(matrix.scaleX, matrix.shearX, matrix.shearY, matrix.scaleY, matrix.translateX, matrix.translateY)
