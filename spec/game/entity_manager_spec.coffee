describe "EntityManager", ->
  type = "SomeType"

  beforeEach ->
    class SomeComponent extends Component
      constructor: (@id) ->
        @thisIsAComponent = true
    EntityManager[type] = [SomeComponent]

  describe "reusing IDs", ->
    it "creates new IDs when there are none to be reused", ->
      manager = new EntityManager
      a = manager.create(type)
      b = manager.create(type)
      expect(a).not.to.equal(b)

    it "re-uses IDs", ->
      manager = new EntityManager
      a = manager.create(type)
      manager.release(a)
      b = manager.create(type)
      expect(a).to.equal(b)

  describe "component creation", ->
    it "throws an error when creating an unknown entity type", ->
      manager = new EntityManager
      expect(-> manager.create()).to.throw(/unknown entity type/)

    it "creates new components when there are none to be reused", ->
      manager = new EntityManager
      a = manager.create(type)
      ai = manager[a]
      b = manager.create(type)
      bi = manager[b]
      expect(ai["SomeComponent"].id).to.equal(a)
      expect(bi["SomeComponent"].id).to.equal(b)
      expect(ai).not.to.equal(bi)

    it "re-uses components", ->
      manager = new EntityManager
      a = manager.create(type)
      ai = manager[a]
      expect(ai["SomeComponent"].id).to.equal(a)
      expect(ai["SomeComponent"].thisIsAComponent).to.be.true
      ai["SomeComponent"].thisIsAComponent = false
      expect(ai["SomeComponent"].thisIsAComponent).to.be.false

      manager.release(a)

      b = manager.create(type)
      bi = manager[b]
      expect(bi["SomeComponent"].id).to.equal(b)
      expect(bi["SomeComponent"].thisIsAComponent).to.be.true

      expect(a).to.equal(b)
      expect(ai).to.equal(bi)

  it "can look up entities by #[]", ->
    manager = new EntityManager
    a = manager.create(type)
    ai = manager[a]
    expect(ai["SomeComponent"].id).to.equal(a)
    expect(ai["SomeComponent"].thisIsAComponent).to.be.true

  xit "can be iterated over (but does not guarantee order)", ->
    toArray = (manager) -> id for id in manager
    manager = new EntityManager

    expect(toArray(manager)).to.be.empty
    a = manager.create(type)
    expect(toArray(manager)).to.have.members([a])
    b = manager.create(type)
    expect(toArray(manager)).to.have.members([a, b])
    c = manager.create(type)
    expect(toArray(manager)).to.have.members([a, b, c])
    d = manager.create(type)
    expect(toArray(manager)).to.have.members([a, b, c, d])
    manager.release(b)
    expect(toArray(manager)).to.have.members([a, d, c])
    e = manager.create(type)
    expect(toArray(manager)).to.have.members([a, d, c, e])
    expect(b).to.equal(e)
