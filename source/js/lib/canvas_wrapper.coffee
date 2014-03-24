class @CanvasAPI
  constructor: (@canvas) ->
    @context = @canvas.getContext("2d")
    @context.font = "16px Helvetica Neue"
    @transforms = []
    @currentTransform = mat2d.create()

  save: ->
    @transforms.push(mat2d.clone(@currentTransform))
    @context.save()

  restore: ->
    @context.restore()
    @currentTransform = @transforms.pop()

  translate: (v) ->
    mat2d.translate(@currentTransform, @currentTransform, v)
    @setTransform(@currentTransform)

  scale: (v) ->
    mat2d.scale(@currentTransform, @currentTransform, v)
    @setTransform(@currentTransform)

  setTransform: (m) ->
    @currentTransform = m
    [ scaleX, shearX, shearY, scaleY , translateX, translateY ] = m
    @context.setTransform(scaleX, shearX, shearY, scaleY, translateX, translateY)

  clear: ->
    @save()
    @setTransform(mat2d.identity(@currentTransform))
    @context.clearRect(0, 0, @canvas.width, @canvas.height)
    @restore()
