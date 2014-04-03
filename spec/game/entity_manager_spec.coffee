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
    beforeEach ->
      @id = @entities.create()
      @entity = @entities[@id]

    describe "#addComponent", ->
      it "creates and attaches a new component to the entity", ->
        objA = {}
        objAComponent = { create: (-> objA) }
        objB = {}
        objBComponent = { create: (-> objB) }

        spyA = sinon.spy(objAComponent, "create")
        spyB = sinon.spy(objBComponent, "create")

        @entity.addComponent("position", objAComponent)
        @entity.addComponent("velocity", objBComponent)

        expect(spyA).to.have.been.calledOnce
        expect(spyB).to.have.been.calledOnce
        expect(spyB).to.have.been.calledAfter(spyA)

        expect(@entity.position).to.equal(objA)
        expect(@entity.velocity).to.equal(objB)

      it "passes extraneous arguments to the component initializer", ->
        args = null
        fakeComponent = { create: (-> args = Array::slice.call(arguments)) }

        obj = {}
        @entity.addComponent("position", fakeComponent, 1, 2, obj)

        expect(args).to.have.members([1, 2, obj])

      it "raises an error if the component has already been added", ->
        fakeComponent = { create: (->) }

        @entity.addComponent("position", fakeComponent)
        expect(=> @entity.addComponent("position", fakeComponent)).to.throw(/position already exists/)

    describe "#removeComponent", ->
      it "releases the component with the given name", ->
        obj = {}
        aComponent = { create: (-> obj), release: ((obj) ->) }
        spyCreate = sinon.spy(aComponent, "create")
        spyRelease = sinon.spy(aComponent, "release")

        @entity.addComponent("position", aComponent)
        expect(@entity.position).to.equal(obj)

        @entity.removeComponent("position")
        @entity.addComponent("velocity", aComponent)

        expect(@entity.velocity).to.equal(obj)

        expect(spyCreate).to.have.been.calledTwice
        expect(spyRelease).to.have.been.calledOnce
        expect(spyRelease).to.always.have.been.calledWithExactly(obj)

      it "does nothing if the component does not exist", ->
        @entity.removeComponent("idonotexist")

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

      id = @entities.create (entity) ->
        entity.addComponent("position", fakeComponent)
        entity.addComponent("velocity", fakeComponent)
      entity = @entities[id]
      { position, velocity } = entity

      spy = sinon.spy(fakeComponent, "release")

      @entities.release(id)

      expect(spy).to.have.been.calledTwice
      expect(spy).to.have.been.calledWithExactly(position)
      expect(spy).to.have.been.calledWithExactly(velocity)

    it "raises an error if the entity does not exist", ->
      expect(=> @entities.release("bogus")).to.throw(/bogus does not exist/)

  describe "#withComponents", ->
    beforeEach ->
      @lookup = (ids...) =>
        @entities[id] for id in ids


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

      expect(@entities.withComponents("SoComponent", "SuchComponent")).to.have.members(@lookup(b, c))
      expect(@entities.withComponents("SoComponent")).to.have.members(@lookup(a, b, c))
      expect(@entities.withComponents("SoComponent", "SuchComponent", "AmazeComponent")).to.have.members(@lookup(c))

    it "does not find entities with re-used component infos", ->
      fakeComponent = { create: (-> {}), release: (->) }

      a = @entities.create (entity) ->
        entity.addComponent("such", fakeComponent)
      @entities.release(a)
      b = @entities.create (entity) ->
        entity.addComponent("wow", fakeComponent)

      expect(@entities[a]).to.equal(@entities[b])

      expect(@entities.withComponents("such")).to.be.empty
      expect(@entities.withComponents("wow")).to.have.members(@lookup(b))
