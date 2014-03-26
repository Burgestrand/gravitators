describe "EntityManager", ->
  type = "TestType"

  beforeEach ->
    EntityManager[type] = [Component.ID]

  it "creates new IDs when there are none to be reused", ->
    manager = new EntityManager
    a = manager.create(type)
    b = manager.create(type)
    expect(a).not.to.equal(b)

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
