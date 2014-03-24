class @DoublyLinkedList
  class @Node
    constructor: (@value) ->
      @prev = null
      @next = null

  constructor: ->
    @root = new DoublyLinkedList.Node
    @tail = @root

  append: (node) ->
    node.next = null
    node.prev = @tail
    @tail.next = node
    @tail = node
    node

  remove: (node) ->
    { prev, next } = node
    @tail = prev if node is @tail
    prev?.next = next
    next?.prev = prev
    node.next = node.prev = null

  pop: ->
    node = @tail
    if node isnt @root
      @remove(node)
      node

  forEach: (fn) ->
    cursor = @root
    while cursor = cursor.next
      fn(cursor.value)

  toString: ->
    values = []
    @forEach ({ value }) ->
      values.push(value)
    "<#{values.join(", ")}>"
