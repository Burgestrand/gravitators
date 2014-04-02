describe "ClassPool", ->
  it "creates a new simple pool based on a constructor", ->
    objA = {}
    objB = {}
    deallocated = []

    class Cow
      constructor: (@a, @b) ->

      deallocate: ->
        deallocated.push(this)

    pool = new ClassPool(Cow)
    a = pool.create(objA, objB)

    expect(a.a).to.equal(objA)
    expect(a.b).to.equal(objB)

    b = pool.create(objB, objA)

    expect(b.a).to.equal(objB)
    expect(b.b).to.equal(objA)

    expect(a).not.to.equal(b)

    pool.release(b)
    expect(deallocated).to.have.members([b])

    c = pool.create(1, 2)
    expect(c.a).to.equal(1)
    expect(c.b).to.equal(2)
    expect(b).to.equal(c)

    pool.release(a)
    expect(deallocated).to.have.members([b, a])

    pool.release(c)
    expect(deallocated).to.have.members([b, a, c])
