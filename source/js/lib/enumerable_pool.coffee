class @EnumerablePool
  class LinkedList
    @node: (key, value) ->
      { key, value }

    constructor: ->
      @root = LinkedList.node()
      @tail = @root

    pop: ->
      node = @tail
      if node isnt @root
        @remove(node)
        node

    push: (node) ->
      node.next = null
      node.prev = @tail
      @tail.next = node
      @tail = node
      node

    remove: (node) ->
      # node should never be @head
      @tail = node.prev if node is @tail
      prev?.next = node.next
      next?.prev = node.prev
      node.next = node.prev = null

    forEach: (fn) ->
      cursor = @root
      while cursor = cursor.next
        fn(cursor.key, cursor.value)

  constructor: (@allocator, @resettor) ->
    @keys = 0
    @active = new LinkedList
    @inactive = new LinkedList
    @key2node = {}
    @key2value = this

  create: ->
    node = @inactive.pop()
    node or= LinkedList.node(@keys++, @allocator())
    @active.push(node)
    @key2node[node.key] = node
    @key2value[node.key] = node.value
    @resettor(node.value)
    node.key

  release: (key) ->
    node = @key2node[key]
    if node
      @key2value[key] = null
      @active.remove(node)
      @inactive.push(node)
      true
    else
      false

  forEach: (fn) ->
    @active.forEach(fn)
