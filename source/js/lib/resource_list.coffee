class @IDPool
  constructor: (value) ->
    @count = 0
    @active = new DoublyLinkedList
    @unused = new DoublyLinkedList
    @id2node = {}

  create: ->
    node = @unused.pop()
    node or= new DoublyLinkedList.Node(@count++)
    @active.append(node)
    @id2node[node.value] = node
    node.value

  release: (id) ->
    node = @id2node[id]
    if node
      @active.remove(node)
      @unused.append(node)
      true
    else
      false

  forEach: (fn) ->
    @active.forEach(fn)
