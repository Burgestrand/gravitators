describe "EntityManager", ->
  type = "SomeType"

  beforeEach ->
    @entities = new EntityManager()

  it "can create new entities", ->
    a = @entities.create()
    b = @entities.create()
    expect(a).not.to.equal(b)

  it "can re-use old entities", ->
    a = @entities.create()
    @entities.release(a)
    b = @entities.create()
    expect(a).to.equal(b)

  it "can look up entities by ID", ->
    a = @entities.create()
    expect(@entities[a].id).to.equal(a)

  it "can iterate over live entities", ->
    toArray = (entities) =>
      id for id in entities

    a = @entities.create()
    expect(toArray(@entities)).to.have.members([a])
    b = @entities.create()
    expect(toArray(@entities)).to.have.members([a, b])
    c = @entities.create()
    expect(toArray(@entities)).to.have.members([a, b, c])
    d = @entities.create()
    expect(toArray(@entities)).to.have.members([a, b, c, d])
    @entities.release(b)
    expect(toArray(@entities)).to.have.members([a, d, c])
    e = @entities.create()
    expect(toArray(@entities)).to.have.members([a, d, c, b])

  describe "Entity", ->
    describe "#addComponent", ->
      it "creates a component with the given name"
      it "raises an error if the component has already been added"

    describe "#removeComponent", ->
      it "releases the component with the given name"

  describe "#create()", ->
    it "allows easy initialization through one or more callbacks", ->
      a = null
      id = @entities.create(((entity) -> a = entity))
      expect(@entities[id]).to.equal(a)

      b = null
      c = null
      id = @entities.create(((entity) -> b = entity), ((entity) -> c = entity))
      expect(@entities[id]).to.equal(b)
      expect(@entities[id]).to.equal(c)

  describe "#release()", ->
    it "releases all entity components", ->
      fakeComponent = { create: (-> {}), release: (->) }
      mock = sinon.mock(fakeComponent)

      id = @entities.create (entity) ->
        entity.addComponent("position", fakeComponent)
        entity.addComponent("velocity", fakeComponent)
      entity = @entities[id]

      expectA = mock.expects("release").withExactArgs(entity["position"]).on(fakeComponent)
      expectB = mock.expects("release").withExactArgs(entity["velocity"]).on(fakeComponent)
      @entities.release(id)
      mock.verify()
      sinon.assert.callOrder(expectA, expectB)

    it "raises an error if the entity does not exist", ->
      expect(=> @entities.release("bogus")).to.throw(/bogus does not exist/)

  describe "#withComponents", ->
    it "finds all entities containing all specified components", ->
      fakeComponent = { create: (-> {}), release: (->) }

      a = @entities.create (entity) ->
        entity.addComponent("SoComponent", fakeComponent)

      b = @entities.create (entity) ->
        entity.addComponent("SoComponent", fakeComponent)
        entity.addComponent("SuchComponent", fakeComponent)

      c = @entities.create (entity) ->
        entity.addComponent("SoComponent", fakeComponent)
        entity.addComponent("SuchComponent", fakeComponent)
        entity.addComponent("AmazeComponent", fakeComponent)

      d = @entities.create (entity) ->
        entity.addComponent("SuchComponent", fakeComponent)
        entity.addComponent("AmazeComponent", fakeComponent)

      e = @entities.create (entity) ->
        entity.addComponent("AmazeComponent", fakeComponent)

      expect(@entities.withComponents("SoComponent", "SuchComponent")).to.have.keys(b.toString(), c.toString())
      expect(@entities.withComponents("SoComponent")).to.have.keys(a.toString(), b.toString(), c.toString())
      expect(@entities.withComponents("SoComponent", "SuchComponent", "AmazeComponent")).to.have.keys(c.toString())

    it "does not find entities with re-used component infos", ->
      fakeComponent = { create: (-> {}), release: (->) }

      a = @entities.create (entity) ->
        entity.addComponent("such", fakeComponent)
      @entities.release(a)
      b = @entities.create (entity) ->
        entity.addComponent("wow", fakeComponent)

      expect(@entities[a]).to.equal(@entities[b])

      expect(@entities.withComponents("such")).to.be.empty
      expect(@entities.withComponents("wow")).to.have.keys(b.toString())
