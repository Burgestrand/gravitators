class @CanvasAPI
  constructor: (@canvas) ->
    @context = @canvas.getContext("2d")
    @context.font = "16px Helvetica Neue"
    @transforms = []
    allocator = ->
      mat2d.create()
    initializer = (matrix) ->
      mat2d.identity(matrix)
    @transformPool = new SimplePool(allocator, initializer)
    @currentTransform = @transformPool.create()

  save: ->
    @transforms.push(@currentTransform)
    @setTransform(mat2d.copy(@transformPool.create(), @currentTransform))
    @context.save()

  restore: ->
    @context.restore()
    @transformPool.release(@currentTransform)
    @currentTransform = @transforms.pop()

  translate: (v) ->
    mat2d.translate(@currentTransform, @currentTransform, v)
    @setTransform(@currentTransform)

  scale: (v) ->
    mat2d.scale(@currentTransform, @currentTransform, v)
    @setTransform(@currentTransform)

  rotate: (r) ->
    mat2d.rotate(@currentTransform, @currentTransform, r)
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
