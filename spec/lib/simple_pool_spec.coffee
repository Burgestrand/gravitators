describe "SimplePool", ->
  it "re-uses previously created, and then released, objects", ->
    allocated = 0
    allocator = -> allocated++
    pool = new SimplePool(allocator)

    a = pool.create()
    pool.release(a)
    b = pool.create()
    c = pool.create()
    pool.release(c)
    d = pool.create()

    expect(a).to.equal(b)
    expect(b).not.to.equal(c)
    expect(c).to.equal(d)
    expect(allocated).to.equal(2)

  it "initializes newly allocated objects", ->
    allocator = ->
      {}
    initializer = (obj) ->
      obj.initialized = true
    pool = new SimplePool(allocator, initializer)

    a = pool.create()
    expect(a.initialized).to.be.true

  it "initializes reused objects", ->
    allocator = ->
      {}
    initialized = 0
    initializer = (obj) ->
      obj.initialized = initialized++
    pool = new SimplePool(allocator, initializer)

    a = pool.create()
    expect(a.initialized).to.equal(0)
    pool.release(a)

    b = pool.create()
    expect(b.initialized).to.equal(1)
    expect(a).to.equal(b)

  it "passes given arguments to the initializer", ->
    allocator = -> {}
    initializer = (obj, [a, b]) ->
      obj.a = a
      obj.b = b
    pool = new SimplePool(allocator, initializer)

    a = pool.create("A", "B")
    expect(a.a).to.equal("A")
    expect(a.b).to.equal("B")
    pool.release(a)

    b = pool.create("C", "D")
    expect(b.a).to.equal("C")
    expect(b.b).to.equal("D")
    expect(a).to.equal(b)

  it "deallocates on #release()", ->
    allocator = -> {}
    initializer = ->
    deallocator = (obj) -> obj.deallocated = true
    pool = new SimplePool(allocator, initializer, deallocator)

    a = pool.create()
    pool.release(a)
    expect(a.deallocated).to.be.true
